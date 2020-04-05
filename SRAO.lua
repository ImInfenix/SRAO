SRAO = {}

SRAO.name = "SRAO"


function SRAO:Initialize()
  self.inCombat = IsUnitInCombat("player")

  EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

  d("Initialized")
end

function SRAO.OnAddOnLoaded(event, addonName)
  if addonName ~= SRAO.name then
    return
  end

  SRAO:Initialize()
end

function OnPlayerActivated(eventCode)
  d("|ccc0000S|cff3300R|cff9933A|cff9966O|r addon loaded.")
end

function SRAO.OnPlayerCombatState(eventCode, inCombat)
  if inCombat ~= SRAO.inCombat then
    SRAO.inCombat = inCombat

    if inCombat then
      d("|ccc0000Entering combat.")
    else
      d("Exiting combat.")
    end

  end
end

EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_ADD_ON_LOADED, SRAO.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
