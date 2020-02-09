AutoLogoutAlert = LibStub("AceAddon-3.0"):NewAddon("AutoLogoutAlert","AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AutoLogoutAlert")

do	
	-- Sets the name of the addon
	AutoLogoutAlert.Name = "AutoLogoutAlert";
	-- Pulls back the title of the addon from the TOC file
	AutoLogoutAlert.Title = GetAddOnMetadata(AutoLogoutAlert.Name, "Title");
	-- Pulls back the current version of the file from the TOC file
	AutoLogoutAlert.Version = GetAddOnMetadata(AutoLogoutAlert.Name, "Version");		
end;

-- Defaults settings 
local defaults = {
    profile = {
        enabled = true,
        soundFile = "Default"        
    },
}


-- list of sounds 
local soundPath = "Interface\\AddOns\\AutoLogoutAlert\\sounds\\"

 local soundTable = {
    ["Default"] = "AutoLogoutAlert.mp3",
    ["Woop"] = "0451.ogg",  
    ["Bell"] = "Bell.ogg",
    ["Chime"] = "Chime.ogg",
    ["Kachink"] = "Kachink.ogg",
    ["Link"] = "Link.ogg",
	["Xylo"] = "Xylo.ogg" ,
	["Heart"] = "Heart.ogg",

	["IM"] = "IM.ogg",
	["Info"] = "Info.ogg",
	["Text1"] = "Text1.ogg"
  }


local media = LibStub("LibSharedMedia-3.0")

--------------------------
-- Blizard Options Panel
--------------------------
local options = {
	type = "group",
	name = L["AutoLogoutAlert Options"],
	args = {
		everydesc = {
			order = 0,
			type = "description",
			fontSize = "medium",
			name = L["General options configuration of AutoLogoutAlert"]
		},
		Geneal = {
			type = "group",
			name = L["General"],
			inline = true,
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
					desc = L["Select sound to play"],
					values = soundTable,
					--dialogControl = "LSM30_Statusbar",
					set = function(info,val) 
						AutoLogoutAlert.db.profile.soundFile = val				
						PlaySoundFile(soundPath..soundTable[val],  "Master");
					end	,
					get = function(info) return AutoLogoutAlert.db.profile.soundFile end
				}	
			}
		}
	}
}
  
-------------------------
-- Initialize Events 
-------------------------


function AutoLogoutAlert:OnInitialize()
	-- Called when the addon is loaded	
	self:Initialize();
end

function AutoLogoutAlert:OnEnable()
	-- Called when the addon is enabled
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	AutoLogoutAlert.db.profile.enabled = true
	self:Print("AutoLogoutAlert is now enabled")
end

function AutoLogoutAlert:OnDisable()
	-- Called when the addon is disabled
	self:UnregisterEvent("CHAT_MSG_SYSTEM")
	AutoLogoutAlert.db.profile.enabled = false
	self:Print("AutoLogoutAlert is now disabled")
end

function AutoLogoutAlert:Initialize()

	AutoLogoutAlert.db = LibStub("AceDB-3.0"):New("AutoLogoutAlertDB", defaults, true)
 
    LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoLogoutAlert", options)
    AutoLogoutAlert.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AutoLogoutAlert", "AutoLogoutAlert")
	
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	 
	-- chat commands
	self:RegisterChatCommand("aloa", "ChatCommand")
end;

function AutoLogoutAlert:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	 elseif input == 'enabled' then
		AutoLogoutAlert:OnEnable()
	 elseif input == 'disabled' then
		AutoLogoutAlert:OnDisable()
	 elseif input == 'rl' then
		ReloadUI()
	 else
        LibStub("AceConfigCmd-3.0"):HandleCommand("aloa", "AutoLogoutAlert", input)
    end
end


function AutoLogoutAlert:CHAT_MSG_SYSTEM(Arg1, Arg2)
	if (Arg1) then        
		if (Arg1 == IDLE_MESSAGE) then
			if (AutoLogoutAlert.db.profile.enabled) then 
				PlaySoundFile(soundPath..soundTable[AutoLogoutAlert.db.profile.soundFile],  "Master");
			end;
			--PlaySoundFile("Interface\\AddOns\\AutoLogoutAlert\\AutoLogoutAlert.mp3",  "Master");
		end;
	end;
end;

