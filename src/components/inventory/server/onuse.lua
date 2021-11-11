--[[
  This file is part of FlashLand.
  Created at 11/11/2021 14:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("inventory:useItem", function(itemId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("Tentative d'utiliser un item avec un player invalide (^3%s^7|^3%s^7)"):format(_src, itemId))
        return
    end
    if (not (_FlashServer_Items.exists(itemId))) then
        return
        _FlashLand.err(("Tentative d'utiliser un item inexistant (^3%s^7|^3%s^7)"):format(_src, itemId))
    end
    if (not (_FlashServer_Items.get(itemId):getIsUsable())) then
        return
        _FlashLand.err(("Tentative d'utiliser un item inutilisable (^3%s^7|^3%s^7)"):format(_src, itemId))
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(itemId))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.INVENTORY_NO_ITEM)
        return
    end
    player.inventory:getItem(itemId):use(_src)
    player.inventory:removeItem(itemId, 1)
    player:sendData()
    player:serverResponded()
end)