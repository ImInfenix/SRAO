-- Currency Tracking File

function InitializeCurrencyTracker()

  --Event ticket warning restore init check
  --ShowEventTicketsWarning(GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT) >= 10)

  --Event tickets warning restore
  local left = CurrencyTracker.savedVariables.EventTicketsWarningLeft
  local top = CurrencyTracker.savedVariables.EventTicketsWarningTop

  GUI_EventTicketsWarning:ClearAnchors()
  GUI_EventTicketsWarning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason)
  if(currencyType == CURT_EVENT_TICKETS) then

    --Detect if event tickets quantity >= 10
    ShowEventTicketsWarning(newAmount >= 10)
  end
end

function ShowEventTicketsWarning(show)
  GUI_EventTicketsWarning:SetHidden(not show)
end

function OnIndicatorMoveStopEventTicketsWarning()
  --CurrencyTracker.savedVariables.EventTicketsWarningLeft = GUI_EventTicketsWarning:GetLeft()
  --CurrencyTracker.savedVariables.EventTicketsWarningTop = GUI_EventTicketsWarning:GetTop()
end

EVENT_MANAGER:RegisterForEvent(CurrencyTracker.name, EVENT_CURRENCY_UPDATE, OnCurrencyUpdate)
