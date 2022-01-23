--[[
  This file is part of FlashLand.
  Created at 17/12/2021 18:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("playerMenu:giveItem", function(targetSrc, itemId, amount)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Players.exists(targetSrc))) then
        _FlashServer_Warden.violation(targetSrc, _FlashEnum_WARDENVIOLATION.TARGET_NO_EXISTS)
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSrc)
    if (not (_FlashServer_Items.exists(itemId))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ARGS_OUT_OF_DELIMITATION)
        return
    end
    ---@type _Item
    local item = _FlashServer_Items.get(itemId)
    -- Security
    if (not (_FlashServer_Warden.isCloseEnoughToInteract(GetPlayerPed(_src), GetPlayerPed(targetSrc)))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_INTERACTION_TOO_FAR)
        return
    end
    if (not (player.inventory:hasItemQty(itemId, amount))) then
        player:serverResponded()
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, (_Static_GenericMessages.PLAYER_INVENTORY_NO_ENOUGH_ITEM_TYPE):format(item.label))
        return
    end
    _FlashServer_Inventory.player_removeItem(_src, itemId, amount, function(success)
        if (success) then
            _FlashServer_Inventory.player_addItem(targetSrc, itemId, amount, function(added)
                if (added) then
                    player:sendAdvancedNotificationMugShot(targetSrc, _Static_GenericMessages.INTERACTION, (_Static_GenericMessages.PLAYER_GIVEITEM):format(item.label, amount), "")
                    target:sendAdvancedNotificationMugShot(_src, _Static_GenericMessages.INTERACTION, (_Static_GenericMessages.PLAYER_RECEIVEITEM):format(item.label, amount), "")
                else
                    player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.TARGET_NO_ENOUGH_INVENTORY_SPACE)
                    _FlashServer_Inventory.player_addItem(_src, itemId, amount, function()  end)
                end
            end)
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
        end
        player:serverResponded()
    end)
end)