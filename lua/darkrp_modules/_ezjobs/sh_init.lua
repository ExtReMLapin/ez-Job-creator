hook.Add("loadCustomDarkRPItems", "ezjobs init", function()
	hook.Add("ezJobsLoaded", "dada", function() end)
	--[[
			Here you're supposed to put your job config like : 

			GAMEMODE.CivilProtection = {
				[TEAM_OFFICER] = true,
				[TEAM_DEPUTY] = true,
				[TEAM_POLICEBOSS] = true,
				[TEAM_SHERIFF] = true,
				[TEAM_SEKUNIT] = true,
				[TEAM_SEKSNIPER] = true,
				[TEAM_SEKHEAVY] = true,
				[TEAM_SEKCHIEF] = true,
				[TEAM_FBICHIEF] = true,
			}
		GAMEMODE.DefaultTeam = TEAM_CITIZEN

		If some shipments/others things are using jobs created with ezjobs, put the code creating the shipment here. ... after the comment

		!!! ONLY IF YOU'RE USING JOBS CREATED WITH EZJOBS IN IT !!!

		--]]
	include("ezjobs/sh_main.lua")

	if CLIENT then
		timer.Simple(0, function()
			net.Start("ezJobGettable")
			net.SendToServer()
		end)

		net.Receive("ezJobPushtable", function()
			local cat = net.ReadTable()
			local tbl = net.ReadUInt(15)
			tbl = net.ReadData(tbl) -- i can't really do something else, gmod WriteTable system is fuckedup
			tbl = util.Decompress(tbl)
			tbl = util.JSONToTable(tbl)

			for k, v in pairs(cat) do
				ezJobs.createcategory(v.name, v.color, v.order)
			end

			for k, v in pairs(tbl) do
				ezJobs.createjob(v)
			end

			hook.Run("ezJobsLoaded")
		end)
	else
		include("ezjobs/server/data.lua")
		ezJobs.restoreconfig()

		for k, v in pairs(ezJobs.catoriginal or {}) do
			ezJobs.createcategory(v.name, v.color)
		end

		for k, v in pairs(ezJobs.jobsoriginal) do
			ezJobs.createjob(v)
		end

		hook.Run("ezJobsLoaded")
		ezJobs.loaded = true
		file.Write("exported_ezjobs.txt", "")

		for k, v in pairs(ezJobs.catoriginal or {}) do
			file.Append("exported_ezjobs.txt", ezJobs.cattostring(v.name, v.color, v.order))
		end

		for k, v in pairs(ezJobs.jobsoriginal) do
			file.Append("exported_ezjobs.txt", ezJobs.jobtostring(v))
		end
	end
end)