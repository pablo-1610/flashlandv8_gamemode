--[[
  This file is part of FlashLand.
  Created at 12/12/2021 15:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local function itemExistsInCategories(itemId)
    for _, category in pairs(_ConfigServer.Shops.categories) do
        for _, item in pairs(category.content) do
            if (item.item == itemId) then
                return (true)
            end
        end
    end
    return (false)
end

local function validateBasket(basket)
    for itemId, count in pairs(basket) do
        if (not (_FlashServer_Items.exists(itemId))) then
            return (false)
        end
        if (not (itemExistsInCategories(itemId))) then
            return (false)
        end
    end
    return (true)
end

local function getItemDataFromShopConfig(itemId)
    for _, category in pairs(_ConfigServer.Shops.categories) do
        for _, item in pairs(category.content) do
            if (item.item == itemId) then
                return (item)
            end
        end
    end
    return (nil)
end

_FlashServer_Billing.registerBillEvent("shop_pay", function(_src, method, total, args)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    ---@type _Npc
    local npc = _FlashServer_Npc.get(args.shopNpcId)
    npc:sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")
    if (not (validateBasket(args.basket))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ARGS_OUT_OF_DELIMITATION)
        return
    end
    local refund = 0
    for k, v in pairs(args.basket) do
        ---@type _Item
        local item = _FlashServer_Items.get(k)
        _FlashServer_Inventory.player_addItem(_src, k, v, function(success)
            local shopItem = getItemDataFromShopConfig(k)
            if (not (success)) then
                refund = (shopItem.price * v)
                player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, ("Vous n'avez pas assez de place pour recevoir %s x%s"):format(item.label, v))
                return
            end
        end)
    end
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
end)