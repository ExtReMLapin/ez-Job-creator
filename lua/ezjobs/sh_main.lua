local traces = {"ValveBiped.Bip01_Head1"}

function ezJobs.jobtostring(job)
	local lines = {}
	local tblammo = {}

	for k, v in pairs(job.ammo or {}) do
		tblammo[v] = 255
	end

	if job.max > 1 then
		job.max = math.Round(job.max)
	end

	local admin1 = job.admin and 1 or 0
	local sortOrder = job.order or 100
	lines[1] = Format("	%s = DarkRP.createJob(\"%s\", {", job.code, job.name)
	table.insert(lines, Format("		color = Color(%i, %i, %i),", job.color.r, job.color.g, job.color.b))
	local tblmd = {}

	for k, v in pairs(job.model) do
		tblmd[k] = Format("\"%s\"", v)
	end

	table.insert(lines, Format("		model = { %s },", string.Implode(", ", tblmd)))
	table.insert(lines, Format("		description = [[ %s ]],", job.description))
	local tblwp = {}

	for k, v in pairs(job.weapons) do
		tblwp[k] = Format("\"%s\"", v)
	end

	table.insert(lines, Format("		weapons = { %s },", string.Implode(", ", tblwp)))
	table.insert(lines, Format("		command =  \"%s\",", job.command))
	table.insert(lines, Format("		max =  %f,", job.max))
	table.insert(lines, Format("		salary =  %f,", job.salary or 10))
	table.insert(lines, Format("		admin =  %i,", admin1))
	table.insert(lines, Format("		vote =  %s,", tostring(job.vote)))
	table.insert(lines, Format("		hasLicense =  %s,", tostring(job.license)))
	table.insert(lines, Format("		modelScale =  %f,", job.modelScale or 1))
	table.insert(lines, Format("		maxpocket =  %f,", job.pocket or 1))
	table.insert(lines, "		candemote = true,")
	table.insert(lines, Format("		mayor =  %s,", tostring(job.mayor)))
	table.insert(lines, Format("		chief =  %s,", tostring(job.chief)))
	table.insert(lines, Format("		medic =  %s,", tostring(job.medic)))
	table.insert(lines, Format("		cook =  %s,", tostring(job.cook)))
	--ammo missing cuz im lazy
	table.insert(lines, Format("		category =  \"%s\",", job.category))
	table.insert(lines, Format("		sortOrder =  %i,", sortOrder))
	table.insert(lines, Format("		PlayerLoadout = function(ply)  if SERVER then ply:SetHealth(%i) ply:SetArmor(%i) end end ,", job.health, job.armor))

	if job.customCheck then
		table.insert(lines, Format("		customCheck = function(ply) %s end ,", job.customCheck))
	end

	if job.CustomCheckFailMsg then
		table.insert(lines, Format("		CustomCheckFailMsg = \"%s\" ,", job.CustomCheckFailMsg))
	end

	if (job.level and job.level ~= 0) then
		table.insert(lines, Format("		level =  %i,", job.level))
		table.insert(lines, Format("		lvl =  %i,", job.level))
	end

	table.insert(lines, "		custom = true")
	table.insert(lines, "	})")

	return string.Implode("\n", lines) .. "\n\n\n"
end

function ezJobs.createjob(job)
	local tblammo = {}

	for k, v in pairs(job.ammo or {}) do
		tblammo[v] = 255
	end

	if job.max > 1 then
		job.max = math.Round(job.max)
	end

	local tbljob = {
		color = job.color,
		model = job.model,
		description = job.description,
		weapons = job.weapons,
		command = job.command,
		max = job.max,
		salary = job.salary,
		admin = job.admin and 1 or 0,
		vote = job.vote,
		hasLicense = job.license,
		modelScale = job.modelScale,
		maxpocket = job.pocket,
		candemote = true,
		mayor = job.mayor,
		chief = job.chief,
		medic = job.medic,
		cook = job.cook,
		ammo = tblammo,
		category = job.category,
		sortOrder = job.order or 100,
		PlayerLoadout = function(ply)
			if SERVER then
				ply:SetHealth(job.health)
				ply:SetArmor(job.armor)
			end
		end,
		lvl = job.level,
		level = job.level,
		custom = true
	}

	if tbljob.level == 0 then
		tbljob.level = nil
	end

	if tbljob.lvl == 0 then
		tbljob.lvl = nil
	end

	if job.customCheck then
		tbljob.customCheck = CompileString("local tbl = {...} local ply = tbl[1] " .. job.customCheck, "ezjobs_" .. job.name)
		tbljob.CustomCheckFailMsg = job.CustomCheckFailMsg -- alternative: CustomCheckFailMsg = function(ply, jobTable) return ply:getDarkRPVar("money") < 5000 and "You're piss poor" or "You don't have enough money!" end,
	end

	_G[job.code] = DarkRP.createJob(job.name, tbljob)
	print(string.format("Created job : %s  with ID : [%i]", job.name, _G[job.code]))
end

--  @desc Create a DarkRP category;
--  @args namec String, colorc Color, order Integer;
--  @realm Server;
--  @note Negative amount will take money instead;
function ezJobs.cattostring(namec, colorc, orderc)
	local lines = {}
	lines[1] = "	DarkRP.createCategory{"
	table.insert(lines, "		name = \"" .. namec .. "\",")
	table.insert(lines, "		categorises = \"jobs\",")
	table.insert(lines, "		startExpanded = true,")
	table.insert(lines, Format("		color = Color(%i, %i, %i),", colorc.r, colorc.g, colorc.b))
	table.insert(lines, "		canSee = function(ply) return true end,")
	local order = orderc or 100
	table.insert(lines, Format("		sortOrder = %i", order))
	table.insert(lines, "	}")

	return string.Implode("\n", lines) .. "\n\n\n"
end

function ezJobs.createcategory(namec, colorc, order)
	DarkRP.createCategory{
		name = namec,
		categorises = "jobs",
		startExpanded = true,
		color = colorc,
		canSee = function(ply)
			return true
		end,
		sortOrder = order or 100
	}
end

function ezJobs.modelispm(path)
	local fid = file.Read(path, "GAME")

	for k, v in pairs(traces) do
		if not string.find(fid, v) then
			return false
		end
	end

	return true
end

if CLIENT then
	local g_grds, g_wgrd, g_sz

	function draw.GradientBox(x, y, w, h, al, ...)
		g_grds = {...}
		al = math.Clamp(math.floor(al), 0, 1)

		if (al == 1) then
			local t = w
			w, h = h, t
		end

		g_wgrd = w / (#g_grds - 1)
		local n

		for i = 1, w do
			for c = 1, #g_grds do
				n = c
				if (i <= g_wgrd * c) then break end
			end

			g_sz = i - (g_wgrd * (n - 1))
			surface.SetDrawColor(Lerp(g_sz / g_wgrd, g_grds[n].r, g_grds[n + 1].r), Lerp(g_sz / g_wgrd, g_grds[n].g, g_grds[n + 1].g), Lerp(g_sz / g_wgrd, g_grds[n].b, g_grds[n + 1].b), Lerp(g_sz / g_wgrd, g_grds[n].a, g_grds[n + 1].a))

			if (al == 1) then
				surface.DrawRect(x, y + i, h, 1)
			else
				surface.DrawRect(x + i, y, 1, h)
			end
		end
	end
end