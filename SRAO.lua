SRAO = {}

SRAO.name = "SRAO"

isLoaded = false

function Initialize()
  SRAO.inCombat = IsUnitInCombat("player")
  SRAOIndicator:SetHidden(not SRAO.inCombat)

  EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_PLAYER_COMBAT_STATE, OnPlayerCombatState)

  SRAO.savedVariables = ZO_SavedVars:New("SRAO_SavedVariables", 1, nil, {})
  RestorePosition()
end

function OnAddOnLoaded(event, addonName)
  if addonName ~= SRAO.name then
    return
  end

  Initialize()
  isLoaded = true
end

function OnPlayerActivated(eventCode)
  if(isLoaded) then
    d("|ccc0000S|cff3300R|cff9933A|cff9966O|r addon loaded.")
  end
end

function OnPlayerCombatState(eventCode, inCombat)
  if inCombat ~= SRAO.inCombat or isLoaded then
    SRAO.inCombat = inCombat

    SRAOIndicator:SetHidden(not inCombat)
  end
end

function OnIndicatorMoveStop()
  SRAO.savedVariables.left = SRAOIndicator:GetLeft()
  SRAO.savedVariables.top = SRAOIndicator:GetTop()
end

function RestorePosition()
  local left = SRAO.savedVariables.left
  local top = SRAO.savedVariables.top

  SRAOIndicator:ClearAnchors()
  SRAOIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)

--GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT)
