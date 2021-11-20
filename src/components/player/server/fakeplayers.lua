--[[
  This file is part of FlashLand.
  Created at 20/11/2021 11:38
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Players.createFakePlayer = function(serverId, flashLandId, rank, identity, cash, name)
    local license = (("license:%s"):format(math.random(1,9000000)))
    local player = _Player(serverId, flashLandId, license, rank, identity, cash, {}, {}, "Tenue d'arrivée", {})
    player.inventory = _Inventory(license, _FlashEnum_INVENTORYTYPE.PLAYER, "Sac d'un fake", 15.0, {})
    player.name = name
    _FlashServer_Players.add(player)
end