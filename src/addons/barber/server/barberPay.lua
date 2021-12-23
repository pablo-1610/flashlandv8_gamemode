--[[
  This file is part of VibR1cy Tebex Store.
  Created at 21/12/2021 17:37
  
  Copyright (c) VibR1cy Tebex Store - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Billing.registerBillEvent("barber_pay", function(_src, method, total, args)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    local barberData = _ConfigServer.BarberShop.list[args.barberId]
    ---@type _Npc
    local npc = barberData.npc
    npc:sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")
    --local webhookBuilder = ("[%s] __%s__ (%s) a payé **%s$** à la superette n°**%s**:```lua"):format(player.rank.label, player.name, player.flashId, total, args.shopId)
    local refund = 150
    if (refund > 0) then
        if (method == _FlashEnum_BILLINGPAYMENTMETHOD.CASH) then
            player.cash = (player.cash + refund)
            player:saveData()
            player:sendData()
            _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, (_Static_GenericMessages.BILLING_PAYMENT_FAILED_REFUNDED):format(_FlashUtils.math_price(refund)), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
        elseif (method == _FlashEnum_BILLINGPAYMENTMETHOD.CARD) then
            local accountId = args.accountId
            _FlashServer_Banking.depositToAccount(accountId, refund, function()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, (_Static_GenericMessages.BILLING_PAYMENT_FAILED_REFUNDED):format(_FlashUtils.math_price(refund)), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
            end)
        end
    end
    --FlashServer_Webhooks.send(_Webhooks.SHOP, webhookBuilder)
end)