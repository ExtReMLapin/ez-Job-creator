local pauseeveryframe = 1
local folderblacklist = {"models/xqm/", "models/workshop/", "models/weapons/", "models/xeon133/", "models/w_models/", "models/v_models/", "models/vehicle/", "models/shadertest/", "models/props_windows/"}
ezJobs.pmfinder = {}
ezJobs.pmfinder.listensers = {} -- admins listening to the data
ezJobs.pmfinder.coroutinestatus = 0
ezJobs.pmfinder.countstatus = 0

function ezJobs.pmfinder.make()
	ezJobs.pmfinder.coroutine = coroutine.create(function()
		ezJobs.pmfinder.coroutinestatus = 1
		local i = 0
		local filelist = {}
		local filewhitelist = ".mdl"

		local function getallfiles(path)
			coroutine.yield()

			if path and string.StartWith(path, "models/props") then
				return
			end

			if table.HasValue(folderblacklist, path) then
				return
			end

			path = path or "models/"
			local flist = file.Find(path .. "*", "GAME")
			local dlist = select(2, file.Find(path .. "*", "GAME"))

			if #dlist > 0 then
				for k, v in pairs(dlist) do
					getallfiles(path .. v .. "/")
				end
			end

			for k, v in pairs(flist) do
				if string.EndsWith(v, filewhitelist) then
					table.insert(filelist, path .. v)
					i = i + 1
				end
			end
		end

		getallfiles()

		for k, v in pairs(ezJobs.pmfinder.listensers) do
			net.Start("ezJobsPMGenSendMax")
			net.WriteUInt(i, 18)
			net.Send(k)
		end

		local i1 = 0

		for k, v in pairs(filelist) do
			if i1 % pauseeveryframe == 0 then
				coroutine.yield()
			end

			if not ezJobs.modelispm(v) then
				filelist[k] = nil
			end

			i1 = i1 + 1
			ezJobs.pmfinder.countstatus = i1
		end

		filelist = table.ClearKeys(filelist, false)
		ezJobs.pmfinder.coroutinestatus = 0
		ezJobs.pmfinder.countstatus = 0
		ezJobs.data.unoffplayermodels = table.Copy(filelist)
		ezJobs.saveconfig()
	end)
end