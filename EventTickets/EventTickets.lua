-- Currency Tracking File
local EventTickets = {}

function InitializeCurrencyTracker()

  --Event ticket warning restore init check
  EventTickets.displayWarning = (GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT) >= 10)
  ShowEventTicketsWarning(EventTickets.displayWarning)

  --Event tickets warning restore
  local left = CurrencyTracker.savedVariables.EventTicketsWarningLeft
  local top = CurrencyTracker.savedVariables.EventTicketsWarningTop

  GUI_EventTicketsWarning:ClearAnchors()
  GUI_EventTicketsWarning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason)
  if(currencyType == CURT_EVENT_TICKETS) then
    --Detect if event tickets quantity >= 10
    EventTickets.displayWarning = (newAmount >= 10)
    ShowEventTicketsWarning(true)
  end
end

function ShowEventTicketsWarning(show)
  GUI_EventTicketsWarning:SetHidden(not show or not EventTickets.displayWarning)
end

function OnIndicatorMoveStopEventTicketsWarning()
  CurrencyTracker.savedVariables.EventTicketsWarningLeft = GUI_EventTicketsWarning:GetLeft()
  CurrencyTracker.savedVariables.EventTicketsWarningTop = GUI_EventTicketsWarning:GetTop()
end

function layerPopped(eventCode, layerIndex, activeLayerIndex)
  --Show Warning when going back to game
  ShowEventTicketsWarning(activeLayerIndex == 2)
end

function layerPushed(eventCode, layerIndex, activeLayerIndex)
  --Hide Warning when opening any menu
  ShowEventTicketsWarning(activeLayerIndex == 2)
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_POPPED, layerPopped)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_ACTION_LAYER_PUSHED, layerPushed)
EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_CURRENCY_UPDATE, OnCurrencyUpdate)
