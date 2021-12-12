--[[
  This file is part of FlashLand.
  Created at 12/12/2021 01:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:giveItem", function(targetSource, itemName, amount)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:giveItem sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    print(json.encode(player.rank.permissions))
    if (not (player.rank:hasPermission("admin.giveitem"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_SELECTED_IS_INVALID)
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSource)
    ---@type _Item
    local item = _FlashServer_Items.get(itemName)
    _FlashServer_Inventory.player_addItem(targetSource, itemName, amount, function(success)
        if (success) then
            target:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, (_Static_GenericMessages.PLAYER_MESSAGE_GIVE_ITEM_SUCCESS):format(amount, item.label))
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, (_Static_GenericMessages.STAFF_MESSAGE_GIVE_ITEM_SUCCESS):format(amount, item.label, target:getName()))
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.STAFF_MESSAGE_GIVE_ITEM_ERROR)
        end
    end)
end)