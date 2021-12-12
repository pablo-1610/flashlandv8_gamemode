--[[
  This file is part of FlashLand.
  Created at 11/12/2021 01:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("bill:payBillCash", function(billEvent, total, billArgs)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Billing.billEventExists(billEvent))) then
        player:serverResponded()
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, "Une erreur est survenue lors du règlement de la facture.")
        return
    end
    if (player.cash < total) then
        player:serverResponded()
        _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.NO_ENOUGH_MONEY, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
    end
    player.cash = (player.cash-total)
    player:serverResponded()
    player:saveData()
    player:sendData()
    _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (_Static_GenericMessages.BILLING_PAYMENT_DONE_CASH):format(_FlashUtils.math_price(total)), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
    _FlashLand.toClient("billing:setBillingAsPaid", _src)
    _FlashServer_Billing.triggerBillingEvent(billEvent, _src, _FlashEnum_BILLINGPAYMENTMETHOD.CASH, total, billArgs)
end)