--[[
  This file is part of FlashLand.
  Created at 29/10/2021 00:08
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("players:onSpawn", function()
    local _src = source
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    player:loadInventory()
    player:setSpawned()
    _FlashLand.toClient("players:nowInGame", _src, player)
end)