util.AddNetworkString("ezJobGettable")
util.AddNetworkString("ezJobPushtable")

net.Receive("ezJobGettable", function(len, ply)
	net.Start("ezJobPushtable")
	net.WriteTable(ezJobs.catoriginal)
	local str = util.TableToJSON(ezJobs.jobsoriginal or {})
	local cpr = util.Compress(str)
	local len1 = string.len(cpr)
	net.WriteUInt(len1, 15)
	net.WriteData(cpr, len1)
	net.Send(ply)
end)

net.Receive("ezJobsPMGenRequest", function(len, ply)
	if not ply:canEZJobs() then
		return
	end

	if ezJobs.pmfinder.coroutinestatus == 1 then
		ply:ChatPrint("The server is already generating the playermodel list, you should not even be able to request another one...")
		net.Start("ezJobsMenuRequestReload")
		net.Send(ply)

		return
	end

	ezJobs.pmfinder.make()

	hook.Add("Think", "ezpmfind", function()
		if coroutine.status(ezJobs.pmfinder.coroutine) ~= "dead" then
			coroutine.resume(ezJobs.pmfinder.coroutine)
		else
			timer.Remove("ezJobsTimerNetUpdate")
			hook.Remove("Think", "ezpmfind")

			for k, v in pairs(ezJobs.pmfinder.listensers) do
				net.Start("ezJobsMenuRequestReload")
				net.Send(k)
			end
		end
	end)

	timer.Create("ezJobsTimerNetUpdate", 1, 0, function()
		for k, v in pairs(ezJobs.pmfinder.listensers) do
			net.Start("ezJobspmsendpercent")
			net.WriteUInt(ezJobs.pmfinder.countstatus, 18)
			net.Send(k)
		end
	end)

	for k, v in pairs(ezJobs.pmfinder.listensers) do
		net.Start("ezJobsMenuRequestReload")
		net.Send(k)
	end
end)


util.AddNetworkString( "ezJobspmsendpercent" )
util.AddNetworkString( "ezJobsPMGenRequest"  )
util.AddNetworkString( "ezJobsPMGenSendMax"  )
util.AddNetworkString( "ezJobsMenuStatus"    )
util.AddNetworkString( "ezJobsAddSingleModel")
util.AddNetworkString( "ezJobsAddSingleModelAnswer")
util.AddNetworkString( "ezJobsMenuStatusAnswer")
util.AddNetworkString( "ezJobsMenuRequestReload")
util.AddNetworkString( "ezJobsRequestStopListen" )
util.AddNetworkString( "ezJobsUpdateJob"     )
util.AddNetworkString( "ezJobGettable"       )
util.AddNetworkString( "ezJobPushtable"      )
util.AddNetworkString( "ezJobNewCategory"    )
util.AddNetworkString( "ezJobRemoveCategory"   )
util.AddNetworkString( "ezJobRemoveJob"      )




net.Receive("ezJobRemoveJob",function (len, ply)
	if not ply:canEZJobs() then return end
	local ptr = net.ReadUInt(12);
	ezJobs.data.jobs[ptr] = nil
	ezJobs.saveconfig()
	net.Start("ezJobsMenuRequestReload")
	net.Send(ply)
end)

net.Receive("ezJobNewCategory",function (len, ply)
	if not ply:canEZJobs() then return end
	local tbl = {name = net.ReadString(), color = net.ReadColor(), order = net.ReadUInt(12) }
	table.insert(ezJobs.data.categories, tbl)
	net.Start("ezJobsMenuRequestReload")
	net.Send(ply)
	ezJobs.saveconfig()
end)


net.Receive("ezJobRemoveCategory", function (len, ply)
	if not ply:canEZJobs() then return end
	local id = net.ReadUInt(12);
	ezJobs.data.categories[id] = nil;
	net.Start("ezJobsMenuRequestReload")
	net.Send(ply)
	ezJobs.saveconfig()
end)


net.Receive("ezJobsUpdateJob" ,function (len, ply)
	if not ply:canEZJobs() then return end
	local uid = net.ReadInt(12)

	local tbl = net.ReadTable()
	if uid == -1 then
		table.insert(ezJobs.data.jobs, tbl)
	else
		ezJobs.data.jobs[uid] = tbl
	end
	net.Start("ezJobsMenuRequestReload")
	net.Send(ply)
	ezJobs.saveconfig()
end)

net.Receive("ezJobsAddSingleModel",function (len, ply)
	if not ply:canEZJobs() then return end
	local mdl = net.ReadString()
	if not string.EndsWith(mdl,".mdl") then return end

	net.Start("ezJobsAddSingleModelAnswer")
	if file.Exists(mdl, "GAME") then
		if table.HasValue(ezJobs.data.unoffplayermodels, mdl) then
			net.WriteUInt(3,4)
			net.Send(ply)
			return
		else
			if ezJobs.modelispm(mdl) then
				net.WriteUInt(4,4)
				net.Send(ply)
				return
			end
			table.insert(ezJobs.data.unoffplayermodels, mdl)
			net.WriteUInt(1,4)
			net.Send(ply)
			return
		end
	else
		net.WriteUInt(2,4)
		net.Send(ply)
		return
	end
	ezJobs.saveconfig()
end)

net.Receive("ezJobsMenuStatus",function (len, ply)
	if not ply:canEZJobs() then
		net.Start( "ezJobsMenuStatusAnswer") -- do not turn into unsigned
		net.WriteInt(-1,3)
		net.Send(ply)
	else
		net.Start("ezJobsMenuStatusAnswer")
		net.WriteInt(ezJobs.pmfinder.coroutinestatus,3)
		if ezJobs.pmfinder.coroutinestatus == 0 then
			local str = util.TableToJSON(ezJobs.data)
			local cpr = util.Compress(str)
			local len = string.len(cpr)
			net.WriteUInt(len,15)
			net.WriteData(cpr, len) -- ghetto
		end
		net.Send(ply)
		ezJobs.pmfinder.listensers[ply] = true
	end
end)

net.Receive("ezJobsRequestStopListen",function (len, ply)
	if not ply:canEZJobs() then return end
	ezJobs.pmfinder.listensers[ply] = nil
end)
