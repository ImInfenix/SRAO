--Addon Settings Menu File
local LAM = LibAddonMenu2

function CurrencyTracker.InitializeLAM()
	--LibAddonMenu-2.0 Setup
	local saveData = CurrencyTracker.savedVariables

	--Test if addon is launched for first time for each value picked by user
	if saveData.displayAddonLoadedMessage == nil then saveData.displayAddonLoadedMessage = true end
	if saveData.eventTickets == nil then
		saveData.eventTickets = {}
		saveData.eventTickets.tracking = true
		saveData.eventTickets.GUILeft = 1800
		saveData.eventTickets.GUITop = 400
	end

	local settingsPanel
	local settingsPanelName = CurrencyTracker.name .. "SettingsPanel"
	local settingsPanelData = {
	  type = "panel",
	  name = CurrencyTracker.name,
	  author = CurrencyTracker.author,
	  version = CurrencyTracker.version,
	  website = CurrencyTracker.website
	}

	local settingsOptionsData = {
		{
			type = "header",
			name = "general"
		},
		{
			type = "checkbox",
			name = "Enable start message",
			getFunc = function() return saveData.displayAddonLoadedMessage end,
			setFunc = function(value)
						saveData.displayAddonLoadedMessage = value
			end
		},
		{
			type = "header",
			name = "Event tickets"
		},
		{
			type = "checkbox",
			name = "Enable event tickets tracking",
			getFunc = function() return saveData.eventTickets.tracking end,
			setFunc = function(value)
						saveData.eventTickets.tracking = value
			end
		}
	}

	settingsPanel = LAM:RegisterAddonPanel(settingsPanelName, settingsPanelData)
	LAM:RegisterOptionControls(settingsPanelName, settingsOptionsData)
end
