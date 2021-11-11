--[[
  This file is part of FlashLand.
  Created at 11/11/2021 01:09
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Ranks.getGroupPlayers = function(rankId)
    local players = {}
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Players.getAll()) do
        if (player.rank.id == rankId) then
            players[_src] = player
        end
    end
    return players
end