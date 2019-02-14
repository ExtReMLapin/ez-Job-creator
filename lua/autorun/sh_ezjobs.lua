local meta = FindMetaTable( "Player" )
ezJobs = ezJobs or {}
ezJobs.version = 0.6
ezJobs.loaded = false


function meta:canEZJobs() -- feel free to change this to anything you want, keep in mind it's shared, so don't do serverside-funcs checks
	return self:SteamID64() == "76561198001451981" or self:IsUserGroup("superadmin")
end

if SERVER then
	resource.AddWorkshop("771853886")
	AddCSLuaFile()
	AddCSLuaFile("ezjobs/sh_main.lua")
	AddCSLuaFile("ezjobs/client/main.lua")
	include("ezjobs/server/network.lua")
	include("ezjobs/server/playermodelfinder.lua")

	local SHORT_SCRIPT_NAME = "ez Jobs" -- A short version of your script's name to identify it
	local SCRIPT_ID = 3071 -- The script's ID on gmodstore
	local SCRIPT_VERSION = "1.70" -- [Optional] The version of your script. You don't _have_ to use the update notification feature, so you can remove it from libgmodstore:InitScript if you want to
	local LICENSEE = "76561198001451981" -- [Optional] The SteamID64 of the person who bought the script. They will have access to debug logs, update notifications, etc. If you do not supply this, superadmins (:IsSuperAdmin()) will have permission instead.
	hook.Add("libgmodstore_init",SHORT_SCRIPT_NAME .. "_libgmodstore",function()
		libgmodstore:InitScript(SCRIPT_ID,SHORT_SCRIPT_NAME,{
			version = SCRIPT_VERSION,
			licensee = LICENSEE
		})
	end)
else
	include("ezjobs/client/main.lua")
end
