CurrencyTracker = {}

--AddOn variables
CurrencyTracker.name = "CurrencyTracker"
CurrencyTracker.coloredName = "|ccc0000Curr|cff3300ency |cff9933Trac|cff9966ker|r"
CurrencyTracker.author = "|cff6600Infenix|r"
CurrencyTracker.version = "1.0"
CurrencyTracker.website = "https://github.com/ImInfenix/CurrencyTracker"

local isLoaded = false

function Initialize()
  CurrencyTracker.savedVariables = ZO_SavedVars:NewAccountWide("CurrencyTracker_SavedVariables", 1, nil, {})
  CurrencyTracker.displayAddonLoadedMessage = CurrencyTracker.savedVariables.displayAddonLoadedMessage

  --EventTickets Initializing
  InitializeEventTickets()

  --LibAddonMenu-2.0 Initializing
  InitializeLAM()
end

function OnAddOnLoaded(event, addonName)
  if addonName ~= CurrencyTracker.name or isLoaded then
    return
  end

  Initialize()
  isLoaded = true
end

function OnPlayerActivated(eventCode)
  if(isLoaded and CurrencyTracker.displayAddonLoadedMessage) then
    d(CurrencyTracker.coloredName .. " addon loaded.")
    CurrencyTracker.displayAddonLoadedMessage = false
  end
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
