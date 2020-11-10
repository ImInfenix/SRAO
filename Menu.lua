--Addon Settings Menu File
local LAM = LibAddonMenu2

function CurrencyTracker.InitializeLAM()
	--LibAddonMenu-2.0 Setup
	local saveData = CurrencyTracker.savedVariables
	--Test if addon is launched for first time for each value picked by user
	if saveData.displayAddonLoadedMessage == nil then saveData.displayAddonLoadedMessage = true end

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
			name = "general mais moins quand meme"
		}
	}

	settingsPanel = LAM:RegisterAddonPanel(settingsPanelName, settingsPanelData)
	LAM:RegisterOptionControls(settingsPanelName, settingsOptionsData)
end
