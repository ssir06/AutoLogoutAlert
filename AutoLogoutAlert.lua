AutoLogoutAlert = LibStub("AceAddon-3.0"):NewAddon("AutoLogoutAlert","AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AutoLogoutAlert")

-- Defaults settings 
local defaults = {
    profile = {
        enabled = true,
        soundFile = "Default"        
    },
}

-- list of sounds 
local soundTable = {
  ["Default"] = "Interface\\AddOns\\AutoLogoutAlert\\AutoLogoutAlert.mp3",
  ["Woop"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\0451.ogg",  
  ["Bell"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\Bell.ogg",
  ["Chime"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\Chime.ogg",
  ["Kachink"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\Kachink.ogg",
  ["Link"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\Link.ogg",
  ["Xylo"] = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\Xylo.ogg"  
}

--------------------------
-- Blizard Options Panel
--------------------------
local options = {
	type = "group",
	name = L["AutoLogoutAlert Options"],
	args = {
		enabled = {
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
		 
		},
	
		soundFile = {
			order = 1,
			type = "select",
			name = L["Sound Alerte"],
			desc = L["Sound Alerte"],
			values = soundTable,
			--dialogControl = "LSM30_Statusbar",
			set = function(info,val) 
				AutoLogoutAlert.db.profile.soundFile = val				
				PlaySoundFile(soundTable[val],  "Master");
			end	,
			get = function(info) return AutoLogoutAlert.db.profile.soundFile end
		}	
	}
}
  
-------------------------
-- Initialize Events 
-------------------------
function AutoLogoutAlert:Initialize()

	AutoLogoutAlert.db = LibStub("AceDB-3.0"):New("AutoLogoutAlert", defaults, true)
 
    LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoLogoutAlert", options)
    AutoLogoutAlert.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AutoLogoutAlert", "AutoLogoutAlert")
	
	AutoLogoutAlert:RegisterEvent("CHAT_MSG_SYSTEM");
	AutoLogoutAlert.LoadedStatus["Initialized"] = 1;
end;


function AutoLogoutAlert:ADDON_LOADED(Arg1, Arg2)
	
	if (AutoLogoutAlert.LoadedStatus["Initialized"] == 0 and Arg1 == "AutoLogoutAlert") then		
		-- Start initializing the addon
		AutoLogoutAlert:Initialize();
		AutoLogoutAlert.LoadedStatus["RunLevel"] = 3;
    end
end;


function AutoLogoutAlert:CHAT_MSG_SYSTEM(Arg1, Arg2)
	if (Arg1) then        
		if (Arg1 == IDLE_MESSAGE) then
			if (AutoLogoutAlert.db.profile.enabled) then 
				PlaySoundFile(soundTable[AutoLogoutAlert.db.profile.soundFile],  "Master");
			end;
			--PlaySoundFile("Interface\\AddOns\\AutoLogoutAlert\\AutoLogoutAlert.mp3",  "Master");
		end;
	end;
end;

 
do
	--Creates a new UI frame called "AutoLogoutAlert"
	-- AutoLogoutAlert = CreateFrame("Frame", "AutoLogoutAlert", UIParent);
	-- Sets the name of the addon
	AutoLogoutAlert.Name = "AutoLogoutAlert";
	-- Pulls back the title of the addon from the TOC file
	AutoLogoutAlert.Title = GetAddOnMetadata(AutoLogoutAlert.Name, "Title");
	-- Pulls back the current version of the file from the TOC file
	AutoLogoutAlert.Version = GetAddOnMetadata(AutoLogoutAlert.Name, "Version");
	-- Says what stage the addon loading is at.
	AutoLogoutAlert.LoadedStatus = {};
	-- Say that the addon has not loaded yet.
	AutoLogoutAlert.LoadedStatus["Initialized"] = 0;
	-- Specifies what level the addon is "Running"
	AutoLogoutAlert.LoadedStatus["RunLevel"] = 2;
end;




-- AutoLogoutAlert:Initialize();
-- Catch when this addon has finished loading
-- AutoLogoutAlert:RegisterEvent("ADDON_LOADED");
-- AutoLogoutAlert:Initialize();
--AutoLogoutAlert:SetScript("OnEvent", AutoLogoutAlert.OnEvent);

AutoLogoutAlert:RegisterEvent("ADDON_LOADED");
-- LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoLogoutAlert", options)
-- LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AutoLogoutAlert", "AutoLogoutAlert")