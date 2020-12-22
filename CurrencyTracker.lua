CurrencyTracker = {}

--AddOn variables
CurrencyTracker.name = "CurrencyTracker"
CurrencyTracker.coloredName = "|ccc0000Curr|cff3300ency |cff9933Trac|cff9966ker|r"
CurrencyTracker.author = "|cff6600Infenix|r"
CurrencyTracker.version = "1.0.1"
CurrencyTracker.website = "https://github.com/ImInfenix/CurrencyTracker"

function CurrencyTracker.Initialize()
  CurrencyTracker.savedVariables = ZO_SavedVars:NewAccountWide("CurrencyTracker_SavedVariables", 1, nil, {})
  CurrencyTracker.displayAddonLoadedMessage = CurrencyTracker.savedVariables.displayAddonLoadedMessage

  --LibAddonMenu-2.0 Initializing
  CurrencyTracker.InitializeLAM()

  --EventTickets Initializing
  CurrencyTracker.InitializeEventTickets()

  EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_PLAYER_ACTIVATED, CurrencyTracker.OnPlayerActivated)
end

function CurrencyTracker.OnAddOnLoaded(eventCode, addonName)
  if(addonName ~= CurrencyTracker.name or isLoaded) then
    return
  end

  --Unregister for load event
  EVENT_MANAGER:UnregisterForEvent(addonName, eventCode)

  CurrencyTracker.Initialize()
end

function CurrencyTracker.OnPlayerActivated(eventCode)

    --Unregister for player activated event
    EVENT_MANAGER:UnregisterForEvent(addonName, eventCode)

  if(CurrencyTracker.displayAddonLoadedMessage) then
    d(CurrencyTracker.coloredName .. " addon loaded.")
    CurrencyTracker.displayAddonLoadedMessage = false
  end
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ADD_ON_LOADED, CurrencyTracker.OnAddOnLoaded)
