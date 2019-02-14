local color1 = Color(255, 255, 255, 255)
local color2 = Color(75, 75, 75, 255)
local color3 = Color(122, 122, 122, 255)
local color4 = Color(100, 100, 100, 255)
local colordark = Color(240, 240, 240, 255)
local colorborder = Color(50, 50, 50, 255)
local colorexit = Color(255, 20, 20, 255)
local colornil = Color(0, 0, 0, 0)
local trash = Material("ezjob/trash.png")
local no = Material("ezjob/no.png")
local ok = Material("ezjob/ok.png")
local edit = Material("ezjob/edit.png")
local newj = Material("ezjob/newj.png")
local lag = Material("ezjob/circle.png")
local logo = Material("games/16/all.png")
local DermaPanel
local data = {}
local maxfiles = 1
local currfiles = 0
local funmessage = ""

local function usedcode(code1)
	local used = false

	for k, v in pairs(data.jobs) do
		if v.code == code1 then
			return true
		end
	end

	return used
end

local function confirmdelete(uid)
	local DermaPanelj = vgui.Create("DFrame")
	DermaPanelj:SetPaintShadow(true)
	DermaPanelj:SetSize(600, 200)
	DermaPanelj:SetTitle("")
	DermaPanelj:SetDraggable(true)
	DermaPanelj:MakePopup()
	DermaPanelj:Center()
	DermaPanelj.lblTitle.Paint = function() end
	local txt = "Are you sure you want to delete this job : " .. data.jobs[uid].name .. " ?"

	DermaPanelj.Paint = function(pnl, w, h)
		surface.SetDrawColor(color1)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.SetMaterial(logo)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(5, 5, 16, 16)
		draw.SimpleText("ezJob Confirmation", "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		surface.SetDrawColor(200, 200, 200, 255)
		surface.DrawLine(0, 30, w, 30)
		draw.SimpleText(txt, "ezjobdel", w / 2, h / 2 - 20, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	DermaPanelj.btnClose.Paint = DermaPanel.btnClose.Paint

	DermaPanelj.btnClose.DoClick = function()
		DermaPanelj:Close()
	end

	DermaPanelj.btnMaxim.Paint = DermaPanel.btnMaxim.Paint
	DermaPanelj.btnMinim.Paint = DermaPanel.btnMinim.Paint
	local yes = vgui.Create("DButton", DermaPanelj)
	yes:SetPos(150, 130)
	yes:SetText("")
	yes:SetSize(32, 32)

	yes.DoClick = function()
		net.Start("ezJobRemoveJob")
		net.WriteUInt(uid, 12)
		net.SendToServer()
		DermaPanelj:Close()
	end

	local no1 = vgui.Create("DButton", DermaPanelj)
	no1:SetPos(380, 130)
	no1:SetText("")
	no1:SetSize(32, 32)

	no1.DoClick = function()
		DermaPanelj:Close()
	end

	no1.Paint = function(pnl, w, h)
		surface.SetDrawColor(255, 50, 50, 255)
		surface.SetMaterial(no)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	yes.Paint = function(pnl, w, h)
		surface.SetDrawColor(50, 150, 50, 255)
		surface.SetMaterial(ok)
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

surface.CreateFont("SeTitle", {
	font = "Roboto Regular",
	extended = false,
	size = 30,
	weight = 00,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("ezjobdel", {
	font = "Roboto Regular",
	size = 25,
	weight = 10,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("ezjobnamefont", {
	font = "Roboto Bold Italic",
	size = 50,
	weight = 10,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("ezjobnamefont2", {
	font = "Roboto Bold Italic",
	size = 42,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = famse,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("ezjobnamefont3", {
	font = "Roboto Bold Italic",
	size = 22,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

data.unoffplayermodels = {}
data.playermodels = {}
local funmessages = {"Reverting to GMOD 9...", "Unwelding Boxes...", "Charging Toolgun...", "Breaking Addons...", "Stuffing Ragdolls...", "Unreticulating Splines...", "Refuelling Thrusters...", "Unknotting ropes...", "Painting Barrels...", "Feeding Birds...", "Bathing Father Grigori...", "Decoding Lua's syntax...", "Re-killing Alyx...", "Calibrating Manhacks...", "Cleaning Leafblower...", "Reconfiguring Gravity Matrix...", "Growing Watermelons...", "Mowing Grass...", "Plastering Walls...", "Inflating Balloons...", "Taming Physics...", "Calling Sleep( 1000 ); ...", "Unfreezing The Freeman...", "Patching Broken Update...", "Styling Mossman's Hair...", "Reducing lifespan of Alyx...", "Polishing Kliener's Head...", "Delaying Episode 3...", "Changing Physgun Batteries...", "Breaking Source Engine..."}

local function WindowsLoadingBar(xpos, ypos, x, y, speed, color1, color2, colorg1, colorg2, colorg3, colorg4, colorg5)
	local pos1 = xpos + x * math.tan(SysTime() * speed)
	local bordermax = math.Max(0, (pos1 + x / 5) - (xpos + x))
	local bordermin = math.Max(0, (xpos + x / 5) - pos1)
	surface.SetDrawColor(color1) -- Background
	surface.DrawRect(xpos, ypos, x, y)
	surface.SetDrawColor(color2)

	if (pos1 + x / 5 > xpos) and (pos1 < xpos + x) and pos1 > xpos then
		surface.SetDrawColor(color2)
		surface.DrawRect(pos1, ypos, (x / 5) - bordermax - bordermin, y * (8 / 13))
		surface.SetDrawColor(colorg1)
		surface.DrawRect(pos1, ypos + y * (8 / 13), (x / 5) - bordermax - bordermin, y * (1 / 13))
		surface.SetDrawColor(colorg2)
		surface.DrawRect(pos1, ypos + y * (9 / 13), (x / 5) - bordermax - bordermin, y * (1 / 13))
		surface.SetDrawColor(colorg3)
		surface.DrawRect(pos1, ypos + y * (10 / 13), (x / 5) - bordermax - bordermin, y * (1 / 13))
		surface.SetDrawColor(colorg4)
		surface.DrawRect(pos1, ypos + y * (11 / 13), (x / 5) - bordermax - bordermin, y * (1 / 13))
		surface.SetDrawColor(colorg5)
		surface.DrawRect(pos1, ypos + y * (12 / 13), (x / 5) - bordermax - bordermin, y * (1 / 13))
	end
	-- Last is a quick fix for 3d rendering
end

-- yess
net.Receive("ezJobsPMGenSendMax", function()
	maxfiles = net.ReadUInt(18)
end)

net.Receive("ezJobspmsendpercent", function()
	currfiles = net.ReadUInt(18)
	funmessage = table.Random(funmessages)
end)

local function jobmenu(jid)
	local maxp = ""
	local errormessage = ""
	local errormessagecolor = Color(255, 0, 0)
	local job = data.jobs[jid]

	if jid == -1 then
		job = {
			max = 0.8,
			salary = 75,
			weapons = {},
			model = {},
			ammo = {}
		}
	end

	local DermaPanelj = vgui.Create("DFrame")
	DermaPanelj:SetPaintShadow(true)
	DermaPanelj:SetSize(1200, 800)
	DermaPanelj:SetTitle("")
	DermaPanelj:SetDraggable(true)
	DermaPanelj:MakePopup()
	local x, y = DermaPanel:GetPos()
	DermaPanelj:SetPos(x + 130, y + 30)
	DermaPanelj.lblTitle.Paint = function() end

	DermaPanelj.Paint = function(pnl, w, h)
		surface.SetDrawColor(color1)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.SetMaterial(logo)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(5, 5, 16, 16)

		if jid == -1 then
			draw.SimpleText("ezJob Creator v" .. ezJobs.version, "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("ezJob Editor v" .. ezJobs.version, "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		surface.SetDrawColor(200, 200, 200, 255)
		surface.DrawLine(0, 30, w, 30)
	end

	DermaPanelj.btnClose.Paint = DermaPanel.btnClose.Paint

	DermaPanelj.btnClose.DoClick = function()
		DermaPanelj:Close()
	end

	DermaPanelj.btnMaxim.Paint = DermaPanel.btnMaxim.Paint
	DermaPanelj.btnMinim.Paint = DermaPanel.btnMinim.Paint
	local panel1 = vgui.Create("DPanel", DermaPanelj)
	panel1:SetPos(1, 31)
	panel1:SetSize(1198, 768)

	panel1.Paint = function(pnl, w, h)
		surface.SetDrawColor(color1)
		surface.DrawRect(0, 0, w, h)
		local str

		if jid ~= -1 then
			str = "Editing job : " .. job.name
		else
			str = "Creating a new job."
		end

		draw.SimpleText(str, "ezjobnamefont2", 10, 54, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w, 100)
		surface.DrawLine(898, 0, 898, 100)
		surface.DrawOutlinedRect(0, 99, 400, 30)
		surface.DrawOutlinedRect(399, 99, 799, 30)
		surface.DrawOutlinedRect(0, 129, 400, 100)
		surface.DrawOutlinedRect(399, 128, 799, 30)
		surface.DrawOutlinedRect(0, 229, 400, 30)
		surface.DrawOutlinedRect(399, 157, 799, 31)
		surface.DrawOutlinedRect(0, 259, 400, 30)
		surface.DrawOutlinedRect(399, 187, 799, 31)
		surface.DrawOutlinedRect(0, 289, 400, 30)
		surface.DrawOutlinedRect(399, 217, 799, 31)
		surface.DrawOutlinedRect(0, 319, 400, 30)
		surface.DrawOutlinedRect(399, 247, 799, 31)
		surface.DrawOutlinedRect(0, 349, 400, 30)
		surface.DrawOutlinedRect(399, 277, 799, 31)
		surface.DrawOutlinedRect(0, 379, 400, 30)
		surface.DrawOutlinedRect(399, 307, 799, 31)
		surface.DrawOutlinedRect(0, 409, 400, 30)
		surface.DrawOutlinedRect(0, 439, 400, 30)
		surface.DrawOutlinedRect(0, 469, 400, 30)
		surface.DrawOutlinedRect(0, 538, w, 229)
		surface.DrawOutlinedRect(0, 538, 180, 50)
		draw.SimpleText("Job Name", "SeTitle", 7, 100, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Job Description", "SeTitle", 406, 100, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Job Color", "SeTitle", 7, 130, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL] Can only change from team : ", "SeTitle", 406, 130, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Job command :", "SeTitle", 7, 230, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL][Lua] Custom check :", "SeTitle", 406, 160, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Has license", "SeTitle", 7, 260, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL] Custom error message :", "SeTitle", 406, 190, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Vote required", "SeTitle", 7, 290, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL] Model scale  :", "SeTitle", 406, 220, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Admin only", "SeTitle", 7, 320, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL] Max pocket  :", "SeTitle", 406, 250, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(maxp, "SeTitle", 40, 350, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("[OPTIONAL] Ammo  :", "SeTitle", 406, 280, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Salary", "SeTitle", 7, 380, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Weapons class (double click to move it to the other panel)", "SeTitle", 406, 310, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Category", "SeTitle", 7, 410, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Weapons class (double click to move it to the other panel)", "SeTitle", 406, 310, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Sorting order", "SeTitle", 7, 440, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("HP", "SeTitle", 7, 470, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("ARMOR", "SeTitle", 100, 470, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("LVL", "SeTitle", 270, 470, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Player Models ", "SeTitle", 7, 550, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Job var name ", "SeTitle", 910, 2, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		surface.DrawLine(898, 30, w, 30)
		draw.SimpleText("Mayor ", "SeTitle", 910, 32, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Chief ", "SeTitle", 910, 62, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Medic ", "SeTitle", 1030, 32, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Cook", "SeTitle", 1030, 62, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(errormessage, "SeTitle", 230, 5, errormessagecolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local DermaCheckboxmayor = vgui.Create("DCheckBox", panel1)
	DermaCheckboxmayor:SetPos(990, 40)
	local DermaCheckboxchief = vgui.Create("DCheckBox", panel1)
	DermaCheckboxchief:SetPos(990, 70)
	local DermaCheckboxmedic = vgui.Create("DCheckBox", panel1)
	DermaCheckboxmedic:SetPos(1110, 40)
	local DermaCheckboxcook = vgui.Create("DCheckBox", panel1)
	DermaCheckboxcook:SetPos(1110, 70)
	DermaCheckboxmayor.used = false

	if job.mayor then
		DermaCheckboxmayor:SetValue(1)
		DermaCheckboxmayor.used = true
	end

	DermaCheckboxchief.used = false

	if job.chief then
		DermaCheckboxchief:SetValue(1)
		DermaCheckboxchief.used = true
	end

	DermaCheckboxmedic.used = false

	if job.medic then
		DermaCheckboxmedic:SetValue(1)
		DermaCheckboxmedic.used = true
	end

	DermaCheckboxcook.used = false

	if job.cook then
		DermaCheckboxcook:SetValue(1)
		DermaCheckboxcook.used = true
	end

	local jobcode = vgui.Create("DTextEntry", panel1) -- create the form as a child of frame
	jobcode:SetPos(1065, 0)
	jobcode:SetSize(133, 31)

	if job.code then
		jobcode.used = true
		jobcode:SetText(job.code)
	else
		jobcode.used = false
		jobcode:SetText("Ex : TEAM_HACKER")

		jobcode.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobname = vgui.Create("DTextEntry", panel1) -- create the form as a child of frame
	jobname:SetPos(130, 99)
	jobname:SetSize(270, 30)

	if job.name then
		jobname.used = true
		jobname:SetText(job.name)
	else
		jobname.used = false
		jobname:SetText("")

		jobname.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobdesc = vgui.Create("DTextEntry", panel1) -- create the form as a child of frame
	jobdesc:SetPos(585, 99)
	jobdesc:SetSize(613, 30)

	if job.description then
		jobdesc.used = true
		jobdesc:SetText(job.description)
	else
		jobdesc.used = false
		jobdesc:SetText("")

		jobdesc.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local Mixer = vgui.Create("DColorMixer", panel1)
	Mixer:SetSize(200, 98)
	Mixer:SetPos(200, 130)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(false)
	Mixer:SetColor(job.color or color_white)
	Mixer.used = true
	local DColorPalette = vgui.Create("DColorPalette", panel1)
	DColorPalette:SetPos(150, 130)
	DColorPalette:SetSize(50, 97)

	DColorPalette.DoClick = function(ctrl, color, btn)
		Mixer:SetColor(color)
	end

	local jobcmd = vgui.Create("DTextEntry", panel1) -- create the form as a child of frame
	jobcmd:SetPos(175, 229)
	jobcmd:SetSize(225, 30)

	if job.command then
		jobcmd.used = true
		jobcmd:SetText(job.command)
	else
		jobcmd.used = false
		jobcmd:SetText("enter a command ( without the \"/\" )")

		jobcmd.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local DermaCheckboxlicense = vgui.Create("DCheckBox", panel1)
	DermaCheckboxlicense:SetPos(175, 266)
	DermaCheckboxlicense:SetValue(job.license or 0)
	local DermaCheckboxvote = vgui.Create("DCheckBox", panel1)
	DermaCheckboxvote:SetPos(175, 296)
	DermaCheckboxvote:SetValue(job.vote or 0)
	local DermaCheckboxadmin = vgui.Create("DCheckBox", panel1)
	DermaCheckboxadmin:SetPos(175, 326)
	DermaCheckboxadmin:SetValue(job.admin or 0)
	local DermaNumSlider = vgui.Create("DNumSlider", panel1)
	DermaNumSlider:SetPos(110, 349)
	DermaNumSlider:SetSize(300, 30)
	DermaNumSlider:SetText("")
	DermaNumSlider:SetMin(0)
	DermaNumSlider:SetMax(100)
	DermaNumSlider:SetDecimals(0)

	DermaNumSlider.Slider.Paint = function(self, w, h)
		surface.SetDrawColor(75, 75, 75, 100)
		surface.DrawRect(0, h / 2 - 2, w - 12, 3)
	end

	DermaNumSlider.Slider.Knob.Paint = function(self, w, h)
		surface.SetDrawColor(150, 150, 255, 255)
		surface.DrawRect(0, 0, 3, h)
	end

	if job.max < 1 then
		maxp = "Max players (%)"
		DermaNumSlider:SetValue(job.max * 100 or 100)
	else
		maxp = "Max player (INT)"
		DermaNumSlider:SetValue(job.max or 100)
	end

	local DButton42 = vgui.Create("DButton", panel1)
	DButton42:SetPos(5, 350)
	DButton42:SetText("%/I")
	DButton42:SetSize(30, 28)

	DButton42.DoClick = function()
		if maxp == "Max players (%)" then
			maxp = "Max player (INT)"
		else
			maxp = "Max players (%)"
		end
	end

	local DermaNumSlidersalary = vgui.Create("DNumSlider", panel1)
	DermaNumSlidersalary:SetPos(-70, 379)
	DermaNumSlidersalary:SetSize(400, 30)
	DermaNumSlidersalary:SetText("")
	DermaNumSlidersalary:SetMin(0)
	DermaNumSlidersalary:SetMax(1500)
	DermaNumSlidersalary:SetDecimals(0)
	DermaNumSlidersalary:SetValue(job.salary or 0)
	DermaNumSlidersalary.Slider.Paint = DermaNumSlider.Slider.Paint
	DermaNumSlidersalary.Slider.Knob.Paint = DermaNumSlider.Slider.Knob.Paint
	local DComboBox1 = vgui.Create("DComboBox", panel1)
	DComboBox1:SetPos(120, 409)
	DComboBox1:SetSize(280, 30)
	DComboBox1:SetValue("Job category")
	local tbl = {}

	for k, v in pairs(DarkRP.getCategories().jobs) do
		table.insert(tbl, v.name)
	end

	for k, v in pairs(data.categories) do
		if not table.HasValue(tbl, v.name) then
			table.insert(tbl, v.name)
		end
	end

	for k, v in pairs(tbl) do
		DComboBox1:AddChoice(v)
	end

	if jid ~= -1 then
		i42 = 1

		while (DComboBox1:GetOptionText(i42) ~= nil) do
			if DComboBox1:GetOptionText(i42) == job.category then
				DComboBox1:ChooseOptionID(i42)
				break
			end

			i42 = i42 + 1
		end
	end

	local joborder = vgui.Create("DTextEntry", panel1)
	joborder:SetPos(160, 439)
	joborder:SetSize(240, 30)

	if job.order then
		joborder:SetText(tostring(job.order))
	else
		joborder:SetText("100")
	end

	local dnumberwangHP = vgui.Create("DNumberWang", panel1)
	dnumberwangHP:SetPos(45, 469)
	dnumberwangHP:SetSize(50, 30)
	dnumberwangHP:SetDecimals(0)
	dnumberwangHP:SetMinMax(1, 10000)

	if jid == -1 then
		dnumberwangHP:SetValue(100)
	else
		dnumberwangHP:SetValue(job.health)
	end

	local dnumberwangarmor = vgui.Create("DNumberWang", panel1)
	dnumberwangarmor:SetPos(190, 469)
	dnumberwangarmor:SetSize(60, 30)
	dnumberwangarmor:SetDecimals(0)
	dnumberwangarmor:SetMinMax(0, 1000)

	if jid == -1 then
		dnumberwangarmor:SetValue(0)
	else
		dnumberwangarmor:SetValue(job.armor)
	end

	local dnumberwanglevel = vgui.Create("DNumberWang", panel1)
	dnumberwanglevel:SetPos(320, 469)
	dnumberwanglevel:SetSize(70, 30)
	dnumberwanglevel:SetDecimals(0)
	dnumberwanglevel:SetMinMax(0, 1000)

	if jid == -1 then
		dnumberwanglevel:SetValue(1)
	else
		dnumberwanglevel:SetValue(job.level)
	end

	local jobweapons = vgui.Create("DListView", panel1)
	local jobweapons2 = vgui.Create("DListView", panel1)
	jobweapons:SetMultiSelect(false)
	jobweapons:AddColumn("Job Weapons")
	jobweapons:SetPos(426, 350)
	jobweapons:SetSize(360, 165)

	jobweapons.DoDoubleClick = function(self, id, pnl)
		jobweapons2:AddLine(pnl:GetColumnText(1))
		self:RemoveLine(id)
	end

	jobweapons2:SetMultiSelect(false)
	jobweapons2:AddColumn("Existing weapons")
	jobweapons2:SetPos(810, 350)
	jobweapons2:SetSize(360, 165)

	jobweapons2.DoDoubleClick = function(self, id, pnl)
		jobweapons:AddLine(pnl:GetColumnText(1))
		self:RemoveLine(id)
	end

	local weaponlist = {"weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2", "weapon_brickbat", "weapon_bugbait", "weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_physcannon", "weapon_pistol", "weapon_rpg", "weapon_shotgun", "weapon_smg1", "weapon_striderbuster", "weapon_stunstick"}

	for k, v in pairs(weapons.GetList()) do
		table.insert(weaponlist, v.ClassName)
	end

	for k, v in pairs(weaponlist) do
		if table.HasValue(job.weapons, v) then
			jobweapons:AddLine(v)
		else
			jobweapons2:AddLine(v)
		end
	end

	local jobsource = vgui.Create("DTextEntry", panel1)
	jobsource:SetPos(856, 128)
	jobsource:SetSize(342, 30)

	if job.NeedToChangeFrom then
		jobsource.used = true
		jobsource:SetText(job.NeedToChangeFrom)
	else
		jobsource.used = false
		jobsource:SetText("Example : TEAM_CITIZEN")

		jobsource.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobcheck = vgui.Create("DTextEntry", panel1)
	jobcheck:SetPos(800, 157)
	jobcheck:SetSize(398, 31)

	if job.customCheck then
		jobcheck.used = true
		jobcheck:SetText(job.customCheck)
	else
		jobcheck.used = false
		jobcheck:SetText("Example : return ply:IsVIP()")

		jobcheck.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobcheckmess = vgui.Create("DTextEntry", panel1)
	jobcheckmess:SetPos(820, 187)
	jobcheckmess:SetSize(378, 31)

	if job.CustomCheckFailMsg then
		jobcheckmess.used = true
		jobcheckmess:SetText(job.CustomCheckFailMsg)
	else
		jobcheckmess.used = false
		jobcheckmess:SetText("Example : you can't get this job !")

		jobcheckmess.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobscale = vgui.Create("DTextEntry", panel1)
	jobscale:SetPos(690, 217)
	jobscale:SetSize(508, 31)

	if job.modelScale then
		jobscale.used = true
		jobscale:SetText(job.modelScale)
	else
		jobscale.used = false
		jobscale:SetText("Playermodel size mult")

		jobscale.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobpocket = vgui.Create("DTextEntry", panel1)
	jobpocket:SetPos(690, 247)
	jobpocket:SetSize(508, 31)
	jobpocket:SetText(tostring(job.maxpocket or ""))

	if job.maxpocket then
		jobpocket.used = true
		jobpocket:SetText(tostring(job.maxpocket))
	else
		jobpocket.used = false
		jobpocket:SetText("The amount of items that can fit in the pocket")

		jobpocket.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local jobpammo = vgui.Create("DTextEntry", panel1)
	jobpammo:SetPos(670, 277)
	jobpammo:SetSize(528, 31)

	if job.ammo and #job.ammo > 0 then
		jobpammo.used = true
		jobpammo:SetText(string.Implode(",", job.ammo))
	else
		jobpammo.used = false
		jobpammo:SetText("Add a comma between each ammo class and w/out any space")

		jobpammo.OnGetFocus = function(pnl)
			pnl:SetText("")
			pnl.OnGetFocus = function() end
			pnl.used = true
		end
	end

	local Scroll = vgui.Create("DScrollPanel", panel1)
	local pmlist = vgui.Create("DListView", panel1)
	pmlist:SetMultiSelect(false)
	pmlist:AddColumn("PlayerModel Path (Double click on path to remove it)")
	pmlist:SetPos(7, 595)
	pmlist:SetSize(500, 150)

	pmlist.DoDoubleClick = function(self, id, pnl)
		self:RemoveLine(id)
	end

	for k, v in pairs(job.model) do
		pmlist:AddLine(v)
	end

	Scroll:SetPos(530, 545)
	Scroll:SetSize(658, 220)
	local IconList = vgui.Create("DTileLayout", Scroll)
	IconList:SetBaseSize(64)
	IconList:Dock(FILL)

	table.foreach(data.playermodels, function(k, item)
		local btn = vgui.Create("DButton", IconList)
		btn:SetDoubleClickingEnabled(false)
		btn:SetText("")
		btn:SetSize(64, 64)
		local Icon
		Icon = vgui.Create("ModelImage", btn)
		Icon:SetMouseInputEnabled(false)
		Icon:SetKeyboardInputEnabled(false)
		Icon:SetModel(item, _, "000000000")
		Icon:SetSize(64, 64)

		btn.DoClick = function(self)
			for k, v in pairs(pmlist:GetLines()) do
				if v:GetValue(1) == item then
					return
				end
			end

			pmlist:AddLine(item)
		end
	end)

	table.foreach(data.unoffplayermodels, function(k, item)
		local btn = vgui.Create("DButton", IconList)
		btn:SetDoubleClickingEnabled(false)
		btn:SetText("")
		btn:SetSize(64, 64)
		local Icon
		Icon = vgui.Create("ModelImage", btn)
		Icon:SetMouseInputEnabled(false)
		Icon:SetKeyboardInputEnabled(false)
		Icon:SetModel(item, _, "000000000")
		Icon:SetSize(64, 64)

		btn.DoClick = function(self)
			for k, v in pairs(pmlist:GetLines()) do
				if v:GetValue(1) == item then
					return
				end
			end

			pmlist:AddLine(item)
		end
	end)

	local btnsend = vgui.Create("DButton", panel1)
	btnsend:SetPos(10, 3)
	btnsend:SetSize(32, 32)
	btnsend:SetText("")

	btnsend.Paint = function(pnl, w, h)
		surface.SetDrawColor(50, 150, 50, 255)
		surface.SetMaterial(ok)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	btnsend.DoClick = function(pnl)
		errormessagecolor = Color(255, 0, 0)
		errormessage = ""
		local sndj = {}

		-- job id
		if not jobcode.used then
			errormessage = "*ERROR* You forgot to enter a job var"

			return
		end

		local jcv = jobcode:GetText()

		if not string.StartWith(jcv, "TEAM_") then
			errormessage = "*ERROR* Job var need to start with TEAM_"

			return
		end

		if (jid == -1 and (_G[jcv] or usedcode(jcv))) or (_G[jcv] and job.code ~= jcv) then
			errormessage = "*ERROR* Job var is already used !"

			return
		end

		sndj.code = jcv
		-- job name
		local jnv = jobname:GetText()

		if not jobname.used then
			errormessage = "*ERROR* You forgot to enter a job name"

			return
		end

		if string.len(jnv) < 2 then
			errormessage = "*ERROR* Job name is too short"

			return
		end

		sndj.name = jnv
		--job description
		local jdv = jobdesc:GetText()

		if not jobdesc.used then
			errormessage = "*ERROR* You forgot to enter a description"

			return
		end

		if string.len(jdv) < 2 then
			errormessage = "*ERROR* Job description is too short"

			return
		end

		sndj.description = jdv
		-- job color
		sndj.color = Mixer:GetColor()
		-- command
		local jcv = jobcmd:GetText()

		if not jobcmd.used then
			errormessage = "*ERROR* You forgot to enter a command"

			return
		end

		if string.len(jcv) < 2 then
			errormessage = "*ERROR* Job command is too short"

			return
		end

		if jcv[1] == "/" then
			errormessage = "*ERROR* Remove the \"/\" from the command"

			return
		end

		sndj.command = jcv
		--license
		sndj.license = DermaCheckboxlicense:GetChecked() or nil
		--vote
		sndj.vote = DermaCheckboxvote:GetChecked() or nil
		--admin
		sndj.admin = DermaCheckboxadmin:GetChecked() or nil

		--maxplayer
		if maxp == "Max players (%)" then
			sndj.max = DermaNumSlider:GetValue() / 100
		else
			sndj.max = DermaNumSlider:GetValue()
		end

		--salary
		sndj.salary = math.Round(DermaNumSlidersalary:GetValue())
		--category
		local cat = DComboBox1:GetSelected()

		if not cat then
			errormessage = "*ERROR* You need to select a job category"

			return
		end

		sndj.category = cat
		--orderjob
		local jorder = tonumber(joborder:GetText())

		if not jorder then
			errormessage = "*ERROR* Sorting order is wrong"

			return
		end

		sndj.order = jorder
		--health
		sndj.health = dnumberwangHP:GetValue() or 100
		sndj.armor = dnumberwangarmor:GetValue() or 0
		sndj.level = dnumberwanglevel:GetValue() or 1
		--weapon_class
		local jwv = {}

		for k, v in pairs(jobweapons:GetLines()) do
			jwv[k] = v:GetColumnText(1)
		end

		sndj.weapons = table.ClearKeys(jwv, false)
		--playermodels
		local tblmdl = {}

		for k, v in pairs(pmlist:GetLines()) do
			tblmdl[k] = v:GetColumnText(1)
		end

		if #tblmdl == 0 then
			errormessage = "*ERROR* One player model at least is required"

			return
		end

		sndj.model = table.ClearKeys(tblmdl, false)

		--opt
		--medic and shit
		if DermaCheckboxmayor:GetChecked() then
			sndj.mayor = true
		end

		if DermaCheckboxchief:GetChecked() then
			sndj.chief = true
		end

		if DermaCheckboxcook:GetChecked() then
			sndj.cook = true
		end

		if DermaCheckboxmedic:GetChecked() then
			sndj.medic = true
		end

		-- job source
		local jsv = jobsource:GetText()

		if jobsource.used and jsv ~= "" then
			if not string.StartWith(jsv, "TEAM_") then
				errormessage = "*ERROR* Job source var need to start with TEAM_"

				return
			end

			if (not _G[jsv]) and (not usedcode(jsv)) then
				errormessage = "*ERROR* Job var does not exist !"

				return
			end

			sndj.NeedToChangeFrom = jsv
		end

		--custom lua check
		local jcluav = jobcheck:GetText()
		local jcluavstr = "local tbl = {...} local ply = tbl[1] "

		if jobcheck.used and jcluav ~= "" then
			errormessage = "COULD NOT COMPILE CUSTOM CHECK"
			local foo = CompileString(jcluavstr .. "ply:Alive()  " .. jcluav, "EZJOBSCOMPILER", true)
			pcall(foo(LocalPlayer()))
			errormessage = ""
			sndj.customCheck = jcluav
		end

		--job.customCheck:
		local jcmv = jobcheckmess:GetText()

		if jobcheckmess.used and string.len(jcmv) > 1 then
			sndj.CustomCheckFailMsg = jcmv
		end

		-- job scale
		local jmsv = tonumber(jobscale:GetText())

		if jobscale.used and jmsv then
			sndj.modelScale = jmsv
		end

		-- pocket
		local jpv = tonumber(jobpocket:GetText())

		if jobpocket.used and jpv then
			sndj.pocket = jpv
		end

		--ammo
		sndj.ammo = {}
		local jav = jobpammo:GetText() -- ohno, not jav

		if jobpammo.used and jav ~= "" then
			if string.find(jav, " ") then
				errormessage = "*ERROR* Remove the spaces from the ammo list"

				return
			end

			sndj.ammo = string.Explode(",", jav)
		end

		net.Start("ezJobsUpdateJob")
		net.WriteInt(jid, 12)
		net.WriteTable(sndj)
		net.SendToServer()
		DermaPanelj:Close()
	end

	local btnabort = vgui.Create("DButton", panel1)
	btnabort:SetPos(55, 3)
	btnabort:SetSize(32, 32)
	btnabort:SetText("")

	btnabort.Paint = function(pnl, w, h)
		surface.SetDrawColor(175, 50, 50, 255)
		surface.SetMaterial(no)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	btnabort.DoClick = function()
		DermaPanelj:Close()
	end
end

local function extendmenu()
	DermaPanel.Paint = function(pnl, w, h)
		surface.SetDrawColor(color1)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.SetMaterial(logo)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(5, 5, 16, 16)
		draw.SimpleText("ezJob Manager v" .. ezJobs.version, "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		surface.SetDrawColor(200, 200, 200, 255)
		surface.DrawLine(0, 30, w, 30)
	end

	local sheet = vgui.Create("DPropertySheet", DermaPanel)
	sheet.m_iPadding = 0
	sheet:SetPos(5, 50)
	sheet:SetSize(1190, 650)
	local panel1 = vgui.Create("DPanel", sheet)
	sheet:AddSheet("                    ", panel1, "icon16/cross.png")
	local panel2 = vgui.Create("DPanel", sheet)
	local panel3 = vgui.Create("DPanel", sheet)
	panel2:SetSize(1198, 768)
	panel3:SetSize(1198, 768)
	local panel4 = vgui.Create("DPanel", sheet)
	sheet:AddSheet("                                                    ", panel4, "icon16/user.png")
	sheet:AddSheet("                                                    ", panel2, "icon16/user.png")
	sheet:AddSheet("                                                    ", panel3, "icon16/user.png")

	for k, v in pairs(sheet.Items) do
		v.Tab.Paint = function(pnl, w, h)
			surface.SetDrawColor(colordark)
			surface.DrawRect(0, 0, w - 5, h)
			surface.SetDrawColor(colorborder)
			surface.DrawOutlinedRect(0, 0, w - 5, h)
			draw.SimpleText(pnl.text, "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		v.Tab.Image.Paint = function() end
	end

	local countpm = #data.unoffplayermodels
	sheet.Items[1].Tab.text = "Main menu"
	sheet.Items[2].Tab.text = "Job Categories"
	sheet.Items[4].Tab.text = Format("Listed Player Models (%i)", #data.playermodels)
	sheet.Items[3].Tab.text = Format("Unlisted Player Models (%i)", countpm)
	sheet.Paint = function() end
	sheet.tabScroller.Paint = function() end

	panel1.Paint = function(pnl, w, h)
		surface.SetDrawColor(colordark)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
	end

	local panel4error = ""

	panel4.Paint = function(pnl, w, h)
		surface.SetDrawColor(colordark)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
		surface.DrawOutlinedRect(0, 0, 200, 53)
		draw.SimpleText("Job categories", "SeTitle", 14, 10, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(panel4error, "SeTitle", 300, 10, colorexit, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		surface.DrawOutlinedRect(17, 360, (w - 40) / 2, 250)
		surface.DrawOutlinedRect(17, 360, 200, 50)
		draw.SimpleText("New category", "SeTitle", 34, 370, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	panel2.Paint = function(pnl, w, h)
		surface.SetDrawColor(colordark)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawLine(pnl:GetWide() / 2.5, 0, pnl:GetWide() / 2.5, pnl:GetTall())
		surface.DrawLine(0, 465, pnl:GetWide() / 2.5, 465)
		surface.DrawLine(0, 140, pnl:GetWide() / 2.5, 140)
	end

	panel3.Paint = function(pnl, w, h)
		surface.SetDrawColor(colordark)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
	end

	local text2p3 = vgui.Create("DPanel", panel2)
	text2p3:SetPos(15, 15)
	text2p3:SetSize(450, 90)

	text2p3.Paint = function()
		draw.SimpleText("This menu is here to generate a list of all the model who were unlisted as PM", "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("it means you only need to use it if you don't see a playermodel and ", "Trebuchet18", 4, 15, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("if you're 100% sure it's on your server.", "Trebuchet18", 4, 30, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("this process is resource heavy, it's always better to use it when the", "Trebuchet18", 4, 45, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("server is almost empty.May also add player models who are NOT", "Trebuchet18", 4, 60, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("playermodels, because it can't detect if a model is a PM or not.", "Trebuchet18", 4, 75, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local text3p3 = vgui.Create("DPanel", panel3)
	text3p3:SetPos(15, 15)
	text3p3:SetSize(450, 90)

	text3p3.Paint = function()
		draw.SimpleText("This tab is showing you all the playermodel registered using Lua", "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local DButton1 = vgui.Create("DButton", panel2)
	DButton1:SetPos(40, 215)
	DButton1:SetText("")
	DButton1:SetSize(400, 100)

	DButton1.Paint = function(pnl, w, h)
		local color = Color(240, 240, 240, 255)

		if pnl:IsDown() then
			color = Color(180, 180, 180)
		end

		surface.SetDrawColor(color)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
		draw.SimpleText("Generate PlayerModel list", "SeTitle", pnl:GetWide() / 2, pnl:GetTall() / 2, color4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	DButton1.DoClick = function()
		net.Start("ezJobsPMGenRequest")
		net.SendToServer()
	end

	local text1p2 = vgui.Create("DPanel", panel2)
	text1p2:SetPos(15, 165)
	text1p2:SetSize(450, 40)
	local txt1 = Format("Right now there is %i unlisted playermodels in the database, if you added", countpm)

	text1p2.Paint = function()
		if countpm == 0 then
			draw.SimpleText("The unlisted playermodel list seems to be empty,", "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("click on the \"Generate list\" button to generate the list.", "Trebuchet18", 4, 15, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(txt1, "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("playermodels and want want to see them in the list, press the button.", "Trebuchet18", 4, 15, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end

	local text2p2 = vgui.Create("DPanel", panel2)
	text2p2:SetPos(15, 330)
	text2p2:SetSize(450, 215)

	text2p2.Paint = function()
		draw.SimpleText("Generating it is slow, it's going to search for ALL the models", "Trebuchet18", 4, 0, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("present on your server (while ignoring blacklisted folder) and then", "Trebuchet18", 4, 15, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("will reading all of them to detect the presence of playermodel bones.", "Trebuchet18", 4, 30, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("the first part is not using coroutines so it may freeze the ", "Trebuchet18", 4, 45, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("server for few seconds, but the second part is using it.", "Trebuchet18", 4, 60, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("It means you will be able to see the (slow) progress without", "Trebuchet18", 4, 75, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("freezing the server, but it's still resource heavy, it's", "Trebuchet18", 4, 90, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("advised to use it with a SSD.", "Trebuchet18", 4, 105, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		draw.SimpleText("There, you can add models manualy, do this if your server HDD", "Trebuchet18", 4, 150, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("is slow or if <for some reasons> your SSD is slower than a HDD.", "Trebuchet18", 4, 165, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Model path :", "Trebuchet18", 4, 200, color4, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local DButton2 = vgui.Create("DButton", panel2)
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:SetPos(100, 530)
	TextEntry:SetSize(350, 20)
	TextEntry:SetText("models/.../.mdl")
	DButton2:SetPos(100, 560)
	DButton2:SetText("")
	DButton2:SetSize(350, 40)

	DButton2.Paint = function(pnl, w, h)
		local color = Color(240, 240, 240, 255)

		if pnl:IsDown() or pnl:GetDisabled() then
			color = Color(180, 180, 180)
		end

		surface.SetDrawColor(color)
		surface.DrawRect(0, 0, w - 5, h)
		surface.SetDrawColor(colorborder)
		surface.DrawOutlinedRect(0, 0, w - 5, h)
		draw.SimpleText("Send model to server", "SeTitle", pnl:GetWide() / 2, pnl:GetTall() / 2, color4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	DButton2.DoClick = function()
		net.Start("ezJobsAddSingleModel")
		net.WriteString(TextEntry:GetText())
		net.SendToServer()
	end

	DButton2:SetEnabled(false)

	DButton2.Think = function(pnl)
		pnl:SetEnabled(string.EndsWith(TextEntry:GetText(), ".mdl"))
	end

	net.Receive("ezJobsAddSingleModelAnswer", function()
		local i = net.ReadUInt(4)

		if i == 1 then
			TextEntry:SetText("Model added !")
			table.insert(data.unoffplayermodels, TextEntry:GetText())
			countpm = #data.unoffplayermodels
		end

		if i == 2 then
			TextEntry:SetText("*ERROR* Could not find the model on the server.")
		end

		if i == 3 then
			TextEntry:SetText("Model already in DB!")
		end

		if i == 4 then
			TextEntry:SetText("Model found on server but does not seems to be a playerModel!")
		end
	end)

	local Scroll = vgui.Create("DScrollPanel", panel2)
	Scroll:SetPos(480, 20)
	Scroll:SetSize(700, 600)
	local IconList = vgui.Create("DTileLayout", Scroll)
	IconList:SetBaseSize(64)
	IconList:Dock(FILL)

	table.foreach(data.unoffplayermodels, function(k, item)
		local btn = vgui.Create("DButton", IconList)
		btn:SetDoubleClickingEnabled(false)
		btn:SetText("")
		btn:SetSize(64, 64)
		local Icon
		Icon = vgui.Create("ModelImage", btn)
		Icon:SetMouseInputEnabled(false)
		Icon:SetKeyboardInputEnabled(false)
		Icon:SetModel(item, _, "000000000")
		Icon:SetSize(64, 64)

		btn.DoClick = function(self)
			Icon:RebuildSpawnIcon()
		end
	end)

	local Scroll = vgui.Create("DScrollPanel", panel3)
	Scroll:SetPos(13, 50)
	Scroll:SetSize(1170, 550)
	local IconList = vgui.Create("DTileLayout", Scroll)
	IconList:SetBaseSize(64)
	IconList:Dock(FILL)

	table.foreach(data.playermodels, function(k, item)
		local btn = vgui.Create("DButton", IconList)
		btn:SetDoubleClickingEnabled(false)
		btn:SetText("")
		btn:SetSize(64, 64)
		local Icon
		Icon = vgui.Create("ModelImage", btn)
		Icon:SetMouseInputEnabled(false)
		Icon:SetKeyboardInputEnabled(false)
		Icon:SetModel(item, _, "000000000")
		Icon:SetSize(64, 64)

		btn.DoClick = function(self)
			Icon:RebuildSpawnIcon()
		end
	end)

	local Scroll = vgui.Create("DScrollPanel", panel1)
	Scroll:Dock(FILL)
	local dpanel = vgui.Create("DPanel", Scroll)
	dpanel:SetSize(1150, 100)

	dpanel.Paint = function(self, w, h)
		local c = HSVToColor((math.cos(CurTime()) + 1) * 180, 0.1, 1)
		draw.GradientBox(-1, 0, w, h, 0, c, colornil)
		draw.SimpleText("New job", "ezjobnamefont", 120, h / 2, colorborder, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	dpanel:SetPos(10, 5)
	local dButton = vgui.Create("DButton", dpanel)
	dButton:SetSize(64, 64)
	dButton:SetText("")
	dButton:SetPos(dpanel:GetWide() - 64 - 32 / 2, (dpanel:GetTall() - 64 - 32 / 2))

	dButton.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(newj)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	dButton.DoClick = function()
		jobmenu(-1, DermaMenu)
	end

	local ik = 1

	for k, v in pairs(data.jobs) do
		local dpanel = vgui.Create("DPanel", Scroll)
		dpanel:SetSize(1150, 64)

		dpanel.Paint = function(self, w, h)
			--[[draw.RoundedBox(16, 0, 0, w, h, color2)
 			draw.RoundedBox(16, 1, 1, w-2,h-2, colordark2 )]]
			draw.GradientBox(-1, 0, w, h, 0, v.color, colornil)
			draw.SimpleText(v.name, "ezjobnamefont", 120, h / 2, colorborder, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		dpanel:SetPos(10, 74 * (ik - 1) + 115)
		local Icon = vgui.Create("ModelImage", dpanel)
		Icon:SetMouseInputEnabled(false)
		Icon:SetKeyboardInputEnabled(false)
		Icon:SetModel(v.model[1], _, "000000000")
		Icon:SetSize(64, 64)
		Icon:SetPos(0, 0)
		local dButton = vgui.Create("DButton", dpanel)
		dButton:SetSize(64, 64)
		dButton:SetText("")
		dButton:SetPos(dpanel:GetWide() - 64 - 32 / 2, 0)

		dButton.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(edit)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		dButton.DoClick = function()
			jobmenu(k, DermaMenu)
		end

		local dButton2 = vgui.Create("DButton", dpanel)
		dButton2:SetSize(64, 64)
		dButton2:SetText("")
		dButton2:SetPos(dpanel:GetWide() - 158, 0)

		dButton2.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(trash)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		dButton2.DoClick = function()
			confirmdelete(k)
		end

		ik = ik + 1
	end

	local catlist = vgui.Create("DListView", panel4)
	catlist:SetMultiSelect(false)
	catlist:AddColumn("Existing categories")
	catlist:AddColumn("Sorting order")
	catlist:SetPos(17, 95)
	catlist:SetSize(1150, 250)
	local tbl = {}
	local tblo = {}

	for k, v in pairs(data.categories) do
		table.insert(tbl, v.name)
		table.insert(tblo, v.order)
	end

	for k, v in pairs(tbl) do
		catlist:AddLine(v, tostring(tblo[k]))
	end

	catlist.DoDoubleClick = function(self, id, pnl)
		local uid = nil

		for k, v in pairs(data.categories) do
			if v.name == pnl:GetColumnText(1) then
				uid = k
				break
			end
		end

		net.Start("ezJobRemoveCategory")
		net.WriteUInt(uid, 12)
		net.SendToServer()
		pnl:Remove()
	end

	local Mixer = vgui.Create("DColorMixer", panel4)
	Mixer:SetPos(315, 370)
	Mixer:SetPalette(true)
	Mixer:SetAlphaBar(true)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(30, 100, 160))
	local catname = vgui.Create("DTextEntry", panel4)
	catname:SetPos(20, 420)
	catname:SetSize(133, 33)
	catname.used = false
	catname:SetText("Category name")

	catname.OnGetFocus = function(pnl)
		pnl:SetText("")
		pnl.OnGetFocus = function() end
		pnl.used = true
	end

	local catorder = vgui.Create("DTextEntry", panel4)
	catorder:SetPos(20, 460)
	catorder:SetSize(133, 33)
	catorder.used = false
	catorder:SetText("sorting order")

	catorder.OnGetFocus = function(pnl)
		pnl:SetText("")
		pnl.OnGetFocus = function() end
		pnl.used = true
	end

	local btnsend = vgui.Create("DButton", panel4)
	btnsend:SetPos(180, 420)
	btnsend:SetSize(32, 32)
	btnsend:SetText("")

	btnsend.Paint = function(pnl, w, h)
		surface.SetDrawColor(50, 150, 50, 255)
		surface.SetMaterial(ok)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	btnsend.DoClick = function(pnl)
		if not catname.used then
			panel4error = "*ERROR* A category name is required"

			return
		end

		local var = catname:GetText()
		local found = false

		for k, v in pairs(data.categories) do
			if v.name == var then
				found = true
			end
		end

		if found then
			panel4error = "*ERROR* Category already existing"

			return
		end

		if not catorder.used then
			panel4error = "*ERROR* A category sorting order is required"

			return
		end

		local sorder = tonumber(catorder:GetText())

		if not sorder then
			panel4error = "*ERROR* Category sorting order is incorrect"

			return
		end

		local c1 = Mixer:GetColor()
		local c2 = Color(c1.r, c1.g, c1.b, 255)
		net.Start("ezJobNewCategory")
		net.WriteString(var)
		net.WriteColor(c2)
		net.WriteUInt(sorder, 12)
		net.SendToServer()
	end
end

local ezjobpopup = function()
	if IsValid(DermaPanel) then
		DermaPanel:Remove()
	end

	local loading = true
	DermaPanel = vgui.Create("DFrame")
	DermaPanel:SetSize(1200, 700)
	DermaPanel:SetTitle("")
	DermaPanel:SetDraggable(true)
	DermaPanel:MakePopup()
	DermaPanel:Center()
	DermaPanel.lblTitle.Paint = function() end

	DermaPanel.Paint = function(pnl, w, h)
		surface.SetDrawColor(color1)
		surface.DrawRect(0, 0, w, h)
		surface.SetMaterial(logo)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(5, 5, 16, 16)
		draw.SimpleText("ezJob Creator v" .. ezJobs.version, "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		surface.SetDrawColor(200, 200, 200, 255)
		surface.DrawLine(0, 30, w, 30)

		if loading then
			WindowsLoadingBar(435, 300, 300, 15, 1.2, Color(230, 230, 230), Color(6, 176, 37), Color(16, 179, 46), Color(40, 187, 6), Color(62, 194, 86), Color(69, 196, 96), Color(77, 199, 99)) -- wow
			draw.SimpleText("Waiting for server answer ... (Check for ALL server-side errors if it's stuck on this)", "DermaLarge", pnl:GetWide() / 2, pnl:GetTall() / 2 - 100, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end

	DermaPanel.btnClose.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawLine(10, 10, 20, 20)
		surface.DrawLine(10, 19, 20, 9)
	end

	DermaPanel.btnClose.DoClick = function(button)
		DermaPanel:Close()
		net.Start("ezJobsRequestStopListen")
		net.SendToServer()
	end

	DermaPanel.btnMaxim.Paint = function(panel, w, h)
		surface.SetDrawColor(153, 153, 153, 255)
		surface.DrawOutlinedRect(11, 9, 8, 8)
		surface.SetDrawColor(230, 230, 230, 255)
		surface.DrawRect(9, 11, 8, 8)
		surface.SetDrawColor(153, 153, 153, 255)
		surface.DrawOutlinedRect(9, 11, 8, 8)
	end

	DermaPanel.btnMinim.Paint = function(panel, w, h)
		surface.SetDrawColor(153, 153, 153, 255)
		surface.DrawLine(10, 15, 20, 15)
	end

	net.Start("ezJobsMenuStatus")
	net.SendToServer()

	net.Receive("ezJobsMenuStatusAnswer", function()
		local status = net.ReadInt(3) -- need to stay signed

		if status == -1 then
			DermaPanel:Remove()

			return
		end

		-- not admin
		if status == 1 then
			DermaPanel.Paint = function(pnl, w, h)
				surface.SetDrawColor(color1)
				surface.DrawRect(0, 0, w, h)
				surface.SetMaterial(logo)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(5, 5, 16, 16)
				draw.SimpleText("ezJob Creator v" .. ezJobs.version, "Trebuchet18", 28, 14, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				surface.SetDrawColor(200, 200, 200, 255)
				surface.DrawLine(0, 30, w, 30)
				surface.SetDrawColor(color3)
				surface.DrawRect(200, pnl:GetTall() / 2 + 20, 800, 40)
				surface.SetDrawColor(color2)
				surface.DrawRect(200, pnl:GetTall() / 2 + 20, math.Remap(currfiles, 0, maxfiles, 0, 800), 40)
				draw.SimpleText(Format("The server is checking for all the playermodels (%i/%i)", currfiles, maxfiles), "DermaLarge", pnl:GetWide() / 2, pnl:GetTall() / 2 + 100, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				draw.SimpleText(funmessage, "DermaLarge", pnl:GetWide() / 2, pnl:GetTall() / 2 + 150, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				surface.SetMaterial(lag)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRectRotated(pnl:GetWide() / 2, pnl:GetTall() / 2 - 180, 256, 256, 360 * math.cos(SysTime()))
			end

			return
		end

		-- alrady generating
		if status == 0 then
			local len = net.ReadUInt(15)
			data = net.ReadData(len)
			data = util.Decompress(data)
			data = util.JSONToTable(data)
			extendmenu(data)

			return
		end
	end)

	return DermaPanel
end

net.Receive("ezJobsMenuRequestReload", function()
	if IsValid(DermaPanel) then
		local x, y = DermaPanel:GetPos()
		DermaPanel:Remove()
		ezjobpopup():SetPos(x, y)
	end
end)

concommand.Add("ezjob", function()
	if util.NetworkStringToID("ezJobsMenuStatus") == 0 then
		notification.AddLegacy("The server could not load ezJobs, please read your console for more informations", NOTIFY_ERROR, 20)
		MsgC(Color(50, 255, 50), [[Hello there, looks like ezjobs failed to load on the server.
Here is what you can do :

First, be sure your server is connected to the internet, have the ports 443 and
the one used by the gmod server not blocked (Default is 27015).

 /!\\ Even if it sounds dumb, a server reboot (changelevel/complete reboot, your choice) could do the trick.  /!\\

If you just did a server migration, redownload the addon, each copy downloaded is auto-bound to the first IP that try to use it.

If it's still not working then get in the logs file,
which are in console.log on your server FTP.

If you want help to get logs, here it is : https://www.gmodstore.com/community/threads/2682-how-to-send-real-logs

Open a ticket, upload the logs on pastebin, and send me the pastebin link.

]])

		return
	end

	if LocalPlayer():canEZJobs() then
		ezjobpopup()
	else
		print("You don't have the rights to open EzJobs")
	end
end)