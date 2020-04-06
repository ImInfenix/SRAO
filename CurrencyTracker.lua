CurrencyTracker = {}

CurrencyTracker.name = "CurrencyTracker"
CurrencyTracker.coloredName = "|ccc0000Curr|cff3300ency |cff9933Trac|cff9966ker|r"

isLoaded = false

function Initialize()
  CurrencyTracker.savedVariables = ZO_SavedVars:New("CurrencyTracker_SavedVariables", 1, nil, {})

  InitializeCurrencyTracker()
end

function OnAddOnLoaded(event, addonName)
  if addonName ~= CurrencyTracker.name or isLoaded then
    return
  end

  Initialize()
  isLoaded = true
end

function OnPlayerActivated(eventCode)
  if(isLoaded) then
    d(CurrencyTracker.coloredName .. " addon loaded.")
  end
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
