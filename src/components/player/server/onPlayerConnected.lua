--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashLand.onReceiveWithoutNet("players:newLoadedPlayer", function(_src, data)
    _FlashLand.log(("Le joueur ^5%s^7 s'est ^2connecté"):format(GetPlayerName(_src)))
    ---@param player _Player
    local player = _Player(_src, data.flashId, data.identifier, data.rankId, json.decode(data.identity), data.cash, json.decode(data.skin), json.decode(data.outfits), data.selectedOutfit, json.decode(data.accessories))
    _FlashServer_Players.add(player)
    player:getDbPosition(function(position)
        _FlashLand.toClient("spawn:spawn", _src, position, player.skin, player.outfits[player.selectedOutfit])
    end)
end)