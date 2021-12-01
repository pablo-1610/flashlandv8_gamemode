--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
local function createPlayerLoadout(player, loadoutId)
    return (_FlashServer_Loadout.createInDb(loadoutId, _FlashEnum_INVENTORYTYPE.PLAYER, _ConfigServer.Start.loadoutCapacity, true))
end

_FlashServer_Loadout.playerGetOrCreate = function(_src, cb)
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    local loadoutId = ("player:%s"):format(player.flashId)
    if (_FlashServer_Loadout.exists(loadoutId)) then
        cb(_FlashServer_Loadout.get(loadoutId))
    end

    _FlashServer_Loadout.existsInDb(loadoutId, function(exists)
        if (exists) then
            _FlashServer_Loadout.loadFromDb(loadoutId, function(inventory)
                cb(inventory)
            end)
        else
            cb(createPlayerLoadout(player, loadoutId))
        end
    end)
end