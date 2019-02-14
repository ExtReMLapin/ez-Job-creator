local DEBUGGING = false
if (libgmodstore and not DEBUGGING) then
	-- We don't want to be running multiple times if we've already initialised
	return
end
libgmodstore = {}

function libgmodstore:print(msg,type)
	if (type == "error" or type == "bad") then
		MsgC(Color(255,0,0),"[libgmodstore] ",Color(255,255,255),msg .. "\n")
	elseif (type == "success" or type == "good") then
		MsgC(Color(0,255,0),"[libgmodstore] ",Color(255,255,255),msg .. "\n")
	else
		MsgC(Color(0,255,255),"[libgmodstore] ",Color(255,255,255),msg .. "\n")
	end
end

libgmodstore:print("Getting libgmodstore from GitHub...")

hook.Remove("PlayerInitialSpawn","libgmodstore_fetchwhenready")
hook.Remove("InitPostEntity","libgmodstore_fetchwhenready")
function libgmodstore:FetchWhenReady(...)
	local vararg = {...}
	if (SERVER) then
		if (#player.GetHumans() > 0) then
			http.Fetch(...)
		else
			libgmodstore:print("Waiting for a player to join...")
			hook.Add("PlayerInitialSpawn","libgmodstore_fetchwhenready",function()
				timer.Simple(0,function()
					http.Fetch(unpack(vararg))
				end)
				hook.Remove("PlayerInitialSpawn","libgmodstore_fetchwhenready")
			end)
		end
	else
		if (libgmodstore_ClientWaited) then
			http.Fetch(unpack(vararg))
		else
			hook.Add("InitPostEntity","libgmodstore_fetchwhenready",function()
				timer.Simple(0,function()
					libgmodstore_ClientWaited = true
					http.Fetch(unpack(vararg))
				end)
				hook.Remove("PlayerInitialSpawn","libgmodstore_fetchwhenready")
			end)
		end
	end
end

function libgmodstore:LoadBackup()
	if (not file.Exists("libgmodstore.txt","DATA")) then
		libgmodstore:print("No backup file found! libgmodstore will not work.", "bad")
		return
	end
	RunString(file.Read("libgmodstore.txt","DATA"),"libgmodstore")
end
libgmodstore:FetchWhenReady("https://cdn.rawgit.com/WilliamVenner/libgmodstore/master/libgmodstore.lua",function(body,len,headers,code)
	if (code ~= 200) then
		libgmodstore:print("[1] Error while getting updated version of libgmodstore: HTTP " .. code, "bad")
		libgmodstore:LoadBackup()
		return
	end
	if (size == 0) then
		libgmodstore:print("[2] Error while getting updated version of libgmodstore: empty body!", "bad")
		libgmodstore:LoadBackup()
		return
	end
	file.Write("libgmodstore.txt",body)
	RunString(body,"libgmodstore")
end)