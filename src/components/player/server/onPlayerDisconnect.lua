--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNetExposed("playerDropped", function()
    local _src = source
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    player:saveData()
    player:savePosition()
    player.inventory:save()
    player.inventory:destroy()
    local name = GetPlayerName(_src)
    if (_FlashServer_Players.exists(_src)) then
        _FlashLand.log(("Le joueur ^5%s^7 s'est ^1déconnecté"):format(name))
        _FlashServer_Players.remove(_src)
    end
end)