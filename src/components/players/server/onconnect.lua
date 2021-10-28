--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("connected", function()
    local _src = source
    ---@param player _Player
    _FlashServer_Players.load(_src, function(player)
        if(not (player)) then
            _FlashLand.toInternal("players:newPlayer", _src)
        else
            _FlashLand.toInternal("players:newLoadedPlayer", _src, player)
        end
    end)
end)