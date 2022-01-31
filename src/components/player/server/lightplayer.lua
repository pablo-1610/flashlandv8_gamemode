--[[
  This file is part of FlashLand.
  Created at 09/11/2021 23:24
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashServer_Players.getLightPlayer = function(_src)
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    ---@type _Inventory
    local inventory = player.inventory
    ---@type _Loadout
    local loadout = player.loadout
    return (_LightPlayer(player.sId, player.flashId, player.identifier, player.rank, player.identity, player.cash, player.skin, player.outfits, player.selectedOutfit, player.accessories, _LightInventory(inventory.id, inventory.type, inventory.label, inventory.capacity, inventory.content), _LightLoadout(loadout.id, loadout.type, loadout.capacity, loadout.content), player.name, player.rpName))
end

