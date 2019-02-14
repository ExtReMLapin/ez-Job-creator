if not file.Exists("ezjobs", "DATA") then
	file.CreateDir("ezjobs")
end

local function getofficiallist()
	local tbl = {}
	local tbl2 = player_manager.AllValidModels()
	local i = 0

	for k, v in pairs(tbl2) do
		tbl[i] = v
		i = i + 1
	end

	return tbl
end

local bstbl = {
	unoffplayermodels = {},
	settings = {},
	jobs = {},
	categories = {}
}

local jsondata = util.TableToJSON(bstbl, true)

function ezJobs.saveconfig()
	file.Write("ezjobs/config.txt", util.TableToJSON(ezJobs.data, true))
end

function ezJobs.restoreconfig()
	if not file.Exists("ezjobs/config.txt", "DATA") then
		file.Write("ezjobs/config.txt", jsondata)
	end

	ezJobs.data = util.JSONToTable(file.Read("ezjobs/config.txt"))

	for k, v in pairs(ezJobs.data.jobs) do
		v.order = v.order or 100
		v.health = v.health or 100
		v.armor = v.armor or 0
		v.level = v.level or 0
	end

	if ezJobs.data.categories then
		for k, v in pairs(ezJobs.data.categories) do
			v.order = v.order or 100
		end
	end

	ezJobs.jobsoriginal = table.Copy(ezJobs.data.jobs)
	ezJobs.catoriginal = table.Copy(ezJobs.data.categories)
	ezJobs.data.playermodels = getofficiallist()
end