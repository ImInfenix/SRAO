--Event Tickets tracking file
local EventTickets = {}

EventTickets.amountTreshold = 10

function CurrencyTracker.InitializeEventTickets()

  if(not CurrencyTracker.savedVariables.eventTickets.tracking) then
    GUI_EventTicketsWarning:SetHidden(true)
    return
  end

  --Event ticket warning restore init check
  EventTickets.displayWarning = (GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT) >= EventTickets.amountTreshold)

  --Debug
  -- EventTickets.displayWarning  = true

  CurrencyTracker.ShowEventTicketsWarning(EventTickets.displayWarning)

  --Event tickets warning restore
  local left = CurrencyTracker.savedVariables.eventTickets.GUILeft
  local top = CurrencyTracker.savedVariables.eventTickets.GUITop

  GUI_EventTicketsWarning:ClearAnchors()
  GUI_EventTicketsWarning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)

  EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_POPPED, CurrencyTracker.LayerPopped)
  EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_PUSHED, CurrencyTracker.LayerPushed)
  EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_CURRENCY_UPDATE, CurrencyTracker.OnCurrencyUpdate)
end

function CurrencyTracker.OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason)
  if(currencyType == CURT_EVENT_TICKETS) then
    --Detects if event tickets quantity >= 10
    EventTickets.displayWarning = (newAmount >= EventTickets.amountTreshold)
    CurrencyTracker.ShowEventTicketsWarning(true)
  end
end

function CurrencyTracker.ShowEventTicketsWarning(show)
  local display = not show or not EventTickets.displayWarning
  GUI_EventTicketsWarning:SetHidden(display)
  if(display) then
    GUI_EventTicketsWarningText:SetText(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT)
  end
end

function CurrencyTracker.OnIndicatorMoveStopEventTicketsWarning()
  CurrencyTracker.savedVariables.eventTickets.GUILeft = GUI_EventTicketsWarning:GetLeft()
  CurrencyTracker.savedVariables.eventTickets.GUITop = GUI_EventTicketsWarning:GetTop()
end

function CurrencyTracker.LayerPopped(eventCode, layerIndex, activeLayerIndex)
  --Shows warning when going back to game
  CurrencyTracker.ShowEventTicketsWarning(activeLayerIndex == 2)
end

function CurrencyTracker.LayerPushed(eventCode, layerIndex, activeLayerIndex)
  --Hides warning when opening any menu
  CurrencyTracker.ShowEventTicketsWarning(activeLayerIndex == 2)
end
