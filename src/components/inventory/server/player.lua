--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
local function createPlayerInventory(player, inventoryId)
    return (_FlashServer_Inventory.createInDb(inventoryId, _FlashEnum_INVENTORYTYPE.PLAYER, ("Sac de %s"):format(("%s %s"):format(player.identity.firstname, player.identity.lastname:upper())), _ConfigServer.Start.bagCapacity, true))
end

_FlashServer_Inventory.playerGetOrCreate = function(_src)
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    local inventoryId = ("player:%s"):format(player.flashId)
    if (_FlashServer_Inventory.exists(inventoryId)) then
        return _FlashServer_Inventory.get(inventoryId)
    end

    _FlashServer_Inventory.existsInDb(inventoryId, function(exists)
        if (exists) then
            return _FlashServer_Inventory.loadFromDb(inventoryId)
        else
            return createPlayerInventory(player, inventoryId)
        end
    end)

end