--[[
  This file is part of FlashLand.
  Created at 12/12/2021 17:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:removePlayerItem", function(targetSource, itemName, amount)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:removePlayerItem sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.removeplayeritem"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_SELECTED_IS_INVALID)
        player:serverResponded()
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSource)
    ---@type _Item
    local item = _FlashServer_Items.get(itemName)
    _FlashServer_Inventory.player_removeItem(targetSource, itemName, amount, function(success)
        if (success) then
            target:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, (_Static_GenericMessages.PLAYER_MESSAGE_REMOVE_ITEM_SUCCESS):format(amount, item.label))
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, (_Static_GenericMessages.STAFF_MESSAGE_REMOVE_ITEM_SUCCESS):format(amount, item.label, target:getName()))
            _FlashServer_Staff.updatePlayersForStaff()
            player:serverResponded()
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.STAFF_MESSAGE_REMOVE_ITEM_ERROR)
            player:serverResponded()
        end
    end)
end)