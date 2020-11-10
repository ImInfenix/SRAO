--Event Tickets tracking file
local EventTickets = {}
EventTickets.amountTreshold = 10

function CurrencyTracker.InitializeEventTickets()

  --Event ticket warning restore init check
  EventTickets.displayWarning = (GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT) >= EventTickets.amountTreshold)
  CurrencyTracker.ShowEventTicketsWarning(EventTickets.displayWarning)

  --Debug
  -- EventTickets.displayWarning  = true

  --Event tickets warning restore
  local left = CurrencyTracker.savedVariables.EventTicketsWarningLeft
  local top = CurrencyTracker.savedVariables.EventTicketsWarningTop

  GUI_EventTicketsWarning:ClearAnchors()
  GUI_EventTicketsWarning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function CurrencyTracker.OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason)
  if(currencyType == CURT_EVENT_TICKETS) then
    --Detects if event tickets quantity >= 10
    EventTickets.displayWarning = (newAmount >= EventTickets.amountTreshold)
    CurrencyTracker.ShowEventTicketsWarning(true)
  end
end

function ShowEventTicketsWarning(show)
  GUI_EventTicketsWarning:SetHidden(not show or not EventTickets.displayWarning)
end

function CurrencyTracker.OnIndicatorMoveStopEventTicketsWarning()
  CurrencyTracker.savedVariables.EventTicketsWarningLeft = GUI_EventTicketsWarning:GetLeft()
  CurrencyTracker.savedVariables.EventTicketsWarningTop = GUI_EventTicketsWarning:GetTop()
end

function CurrencyTracker.LayerPopped(eventCode, layerIndex, activeLayerIndex)
  --Shows warning when going back to game
  CurrencyTracker.ShowEventTicketsWarning(activeLayerIndex == 2)
end

function CurrencyTracker.LayerPushed(eventCode, layerIndex, activeLayerIndex)
  --Hides warning when opening any menu
  CurrencyTracker.ShowEventTicketsWarning(activeLayerIndex == 2)
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_POPPED, CurrencyTracker.LayerPopped)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_PUSHED, CurrencyTracker.LayerPushed)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_CURRENCY_UPDATE, CurrencyTracker.OnCurrencyUpdate)
