--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:14
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("players:nowInGame", function(player)
    _FlashClient_Cache.setCache("playerData", player)
    _FlashLand.setGameState(_FlashENUM_GAMESTATE.PLAYING)
    _FlashLand.log("Chargement complet effectué, bon jeu !")
end)