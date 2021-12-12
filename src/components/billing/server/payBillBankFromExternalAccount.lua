--[[
  This file is part of FlashLand.
  Created at 11/12/2021 23:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("bill:payBillBankFromExternalAccount", function(billEvent, accountId, pin, total, billArgs)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Billing.billEventExists(billEvent))) then
        player:serverResponded()
        _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BILLING_PAYMENT_FAILED, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
        return
    end
    _FlashServer_Banking.getAccount(accountId, function(account)
        if (not (account)) then
            player:serverResponded()
            _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BILLING_PAYMENT_UNKNOWN_ACCOUNT, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
            return
        end
        -- TODO → Accept payment from illegal & job accounts
        if (account.type == _FlashEnum_BANKACCOUNTTYPE.PERSONAL.id) then
            if (account.pin ~= pin) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BILLING_PAYMENT_WRONG_SECRET_CODE, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                return
            end
            if (account.state == _FlashEnum_BANKACCOUNTSTATE.SUSPENDED) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BILLING_PAYMENT_ACCOUNT_SUSPENDED, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                return
            end
            if (account.balance < total) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BILLING_PAYMENT_NO_ENOUGH_MONEY, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                return
            end
            _FlashServer_Banking.withdrawFromAccount(account.accountId, total, function()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (_Static_GenericMessages.BILLING_PAYMENT_DONE_CASH):format(_FlashUtils.math_price(total)), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                _FlashLand.toClient("billing:setBillingAsPaid", _src)
                billArgs.accountId = accountId
                _FlashServer_Billing.triggerBillingEvent(billEvent, _src, _FlashEnum_BILLINGPAYMENTMETHOD.CARD, total, billArgs)
                player:serverResponded()
            end)
        end
    end)
end)