# gmod-ez-job-creator
also known as ez Job Creator, ui to easily create jobs for gmod

 # One of the best selling gmodstore addons, now free (but unsupported and unupdated)
 
 
 ![](https://i.imgur.com/47nbNtg.png)
 
 DESCRIPTION FROM THE ADDON PAGE :
 
 
 Adding jobs is complicated, boring and slow ? Now with this addon it's just boring !
------------------------------------------------------------------------------------

### And now you can let your admins do the boring work !

  

**Server owner ? Admins want to add jobs but you won't let them get the FTP access ? This addon is for you, it does not require any FTP access.**

**Youtube video vvv**

[![](http://i.imgur.com/AqdEGzm.png)](https://youtu.be/qHmv0dG1r9U)

**Youtube video ^^^**

![](https://i.imgur.com/gyO07pu.png) **No knowledge about Lua required** (But you can code in lua, you can still use the ezCompiler in game for the custom check)

![](https://i.imgur.com/gyO07pu.png) **No FTP access** required to edit/add jobs, **everything is done ingame** and applied at the map change/server restart

![](https://i.imgur.com/gyO07pu.png) Now Supports job levels, armor and health !.

![](https://i.imgur.com/gyO07pu.png) ezGuide will tell you the potentials errors you did while creating a job and explain you how to fix it.

![](https://i.imgur.com/gyO07pu.png) ezCompiler **will not let you send incorrect Lua to your server** if you choosed to add lua in the optional fields.

![](https://i.imgur.com/gyO07pu.png) [ezJobs creator will search for playermodels not added to gmod using Lua, and will not slow down your server](https://youtu.be/uwueX5vIKP0)

![](https://i.imgur.com/gyO07pu.png) ezJobs creator allow multiple people to work on jobs at the same time, and changes will be applied only at the server restart, so the player's experience can't be annoyed by a configuration mistake.

![](https://i.imgur.com/gyO07pu.png) **NEW** export to lua format is now available, it creates a file called exported\_ezjobs.txt in /data/ on your server

Be sure you have the last version of DarkRP and a decent monitor resolution,

Installation / how to use it
============================

Be sure you're using the last [darkrp github version](https://github.com/FPtje/DarkRP/archive/master.zip)

**I** : Drop the folder ezjobs in the addon folder

**II** : If you want to allow peoples others than superadmin to edit jobs, edit the function in

ezJobs/lua/autorun/sh\_ezjobs.lua

**To use it just type this command in your console**

ezjob

  

If you don't have the rights to use it, it will autoclose.

I can't …
=========

ezjobs can export the jobs you created as lua format, it's generated at each server start and it's in data/exported\_ezjobs.txt delete ezjobs (after you made the jobs) and put it in jobs.lua

You are **NOT** required to do this but because of a lot of reasons like the fact i can't add 99999 features to the addon and the darkrp loading order system sucks, it's better to export the code and then edit it.

How to replace default jobs
===========================

go in darkrpmodification/lua/darkrp_config/disabled_defaults.lua

you should have this somewhere :

![](http://i.imgur.com/4XXIB41.png)

Turn everything from false to true.

**be sure you're using the very last version of the darkrp**

If you want to recreate the same jobs, here are the keycodes : DarkRP/gamemode/config/jobrelated.lua

But don't use the same command as the originals because it won't work.

Also you may need to define which jobs are in the police and the default job.

**Using this part of code**

    GAMEMODE.DefaultTeam = TEAM\_SUPERMAN

    GAMEMODE.CivilProtection = {
        \[TEAM\_SUPERMAN\] = true,
        \[TEAM\_JESUS\] = true,
        \[TEAM\_POTATO\] = true,
    }

Since there may be in it jobs created with ezjobs,

you need to put the code i just showed you in there ->

`addons/ezjobs/lua/darkrp_modules/_ezjobs/sh_init.lua`

![](https://puu.sh/stOQk/ebd13355fe.png)

Just replace the vars with the one you created … or the ones you will create.

If you want to create shipments/weapons for ezjobs jobs, put the code at the same place.

you should have something like :

![](http://i.imgur.com/ObUYGb3.png)

How to use customcheck
======================

in the customcheck field, the player var is "ply"

you can do something like

     return table.HasValue({"superadmin","admin", "vip", "vip+"}, ply:GetNWString("usergroup"))

How to make it owner only
=========================

addons/ezjobs/lua/autorun/sh\_ezjobs.lua

![](http://i.imgur.com/ew5e5jQ.gif)

  

===

Support
=======

I'm always happy to help my customers, on my first addon, 100% satisfaction is my target, on my first addon i added features, and i will do the same there, if requested.

I only help people who use the ticket system, don't add me on steam; and if it's required **I** will add you on steam.

Other things
============

I said it before in the description, only the last version of the DarkRP is supported, getting the one from github is a good idea.

API/Hooks
=========

If you want to make your addon compatible with it, like some kind of whitelist system that need all the jobs to be created before initializing, you can do this :

if ezJobs then
    hook.Add("ezJobsLoaded", "init your addon name", function()
        \--\[\[
        wait 1 sec because some jobs can be created on the
        hook execution this is used by people fixing shitty
        addons like the tow truck addon
        \]\]
        timer.Simple(1, function() 
            InitYourAddon()
        end)
    end)
else
    InitYourAddon()
end

If you can't init your addon with one function (could be an include() ), you're an idiot and should stop releasing addons.

Same if you create jobs with timer.Simple, you should be jailed for that and stop releasing addons.

Thanks
------

[Lunaversity 🔥](https://scriptfodder.com/users/view/76561198074425791) for the script idea

[Richard](https://scriptfodder.com/users/view/76561198135875727) for the advices on the UI.

\*\* [Hall of shame](https://gist.github.com/ExtReMLapin/23869fcbd096d0aa212ea5b608cbb324) \*\*

Check out my other dank script

[![](https://media.gmodstore.com/script_banners/6fb6527ff6d72cb8482db4699c625d2b.png)](https://scriptfodder.com/scripts/view/4858)

> I would like to express my sincere apologies to all the jobs creators of

> SF's job section who are now homeless and will have to survive eating

> rats. The next winter is not going to be gentle with you, so you

> better go back in your natural habitat : The Sewer.

> I hope you will be fine and you don't hate me too much

> \-_your friend, Lapin_

google tags :

how to make darkrp jobs

easy darkrp job maker

darkrp job creator

comment faire job darkrp
