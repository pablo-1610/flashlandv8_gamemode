--[[
  This file is part of FlashLand.
  Created at 28/10/2021 15:48
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---player
---@public
---@return _Player
_FlashClient_Cache.getPlayer = function()
    return (_FlashClient_Cache.getCache("playerData"))
end

---@param lightPlayer _LightPlayer
_FlashClient_Cache.onReceive("playerData", function(lightPlayer)
    lightPlayer.rank = _Rank(lightPlayer.rank.id, lightPlayer.rank.label, lightPlayer.rank.weight, lightPlayer.rank.permissions)
    _FlashClient_Cache.setCache("playerData", lightPlayer)
end)

_FlashLand.onReceive("cache:setPlayerData", function(playerData)
    _FlashClient_Cache.setCache("playerData", playerData)
end)