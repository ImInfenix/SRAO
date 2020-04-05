-- Currency Tracking File

function InitializeCurrencyTracker()

  --Event ticket warning restore init check
  ShowEventTicketsWarning(GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT) >= 10)

  --Event tickets warning restore
  local left = SRAO.savedVariables.EventTicketsWarningLeft
  local top = SRAO.savedVariables.EventTicketsWarningTop

  SRAOEventTicketsWarning:ClearAnchors()
  SRAOEventTicketsWarning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason)
  if(currencyType == CURT_EVENT_TICKETS) then
    d("[SRAO] New event tickets amount : " .. newAmount)

    --Detect if event tickets quantity >= 10
    ShowEventTicketsWarning(newAmount >= 10)
  end
end

function ShowEventTicketsWarning(show)
  SRAOEventTicketsWarning:SetHidden(not show)
end

function OnIndicatorMoveStopEventTicketsWarning()
  SRAO.savedVariables.EventTicketsWarningLeft = SRAOEventTicketsWarning:GetLeft()
  SRAO.savedVariables.EventTicketsWarningTop = SRAOEventTicketsWarning:GetTop()
end

EVENT_MANAGER:RegisterForEvent(SRAO.name, EVENT_CURRENCY_UPDATE, OnCurrencyUpdate)

--GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT)
