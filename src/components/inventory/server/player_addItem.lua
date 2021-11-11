--[[
  This file is part of FlashLand.
  Created at 11/11/2021 15:49
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Inventory.player_addItem = function(_src, itemId, qty, cb)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("Tentative d'additem sur un player inexistant (^3%s^7|^3%s^7)"):format(_src, itemId))
        cb(false)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Items.get(itemId))) then
        _FlashLand.err(("Tentative d'addItem avec un item inexistant (^3%s^7|^3%s^7)"):format(_src, itemId))
        cb(false)
        return false
    end
    player.inventory:addItem(itemId, qty, function(success)
        if(success) then
            player:sendData()
        end
        cb(success)
    end)
end