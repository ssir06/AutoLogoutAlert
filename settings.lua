local L = LibStub("AceLocale-3.0"):GetLocale("AutoLogoutAlert", true)

	
local soundTable = {
  ["Default"] = "Interface\\AddOns\\AutoLogoutAlert\\AutoLogoutAlert.mp3",
  ["Woop"] = "Interface\\AddOns\\AutoLogoutAlert\\AutoLogoutAlert2.mp3",  
  ["Custom"] = L["Custom"]
}
local options = {
	type = "group",
	name = L["AutoLogoutAlert Options"],
	args = {}
}

options.args["enabled"] = {
	order = 0,
	type = "toggle",
	name = L["Enable Alerte"],
	desc = L["Activate sound alerte"],
	set = function(info,val) 
		AutoLogoutAlert.db.profile.enabled = val 
	end,
    get = function(info) 
		return AutoLogoutAlert.db.profile.enabled 
	end
	
}
 
options.args["soundFile"] = {
	order = 1,
	type = "select",
	name = L["Sound Alerte"],
	desc = L["Sound Alerte"],
	values = soundTable,
	--dialogControl = "LSM30_Statusbar",
	set = function(info,val) 
	 AutoLogoutAlert.db.profile.soundFile = val
	end	,
    get = function(info) return AutoLogoutAlert.db.profile.soundFile end
}
 

options.args["sep1"] = {
	order = 2,
	type = "description",
	name = "\n"
}

options.args["sep1"] = {
	order = 3,
	type = "description",
	name = "\n"
}
  

LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoLogoutAlert", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AutoLogoutAlert", "AutoLogoutAlert")