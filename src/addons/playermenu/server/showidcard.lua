--[[
  This file is part of FlashLand.
  Created at 15/11/2021 20:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("playerMenu:showIdCard", function(targetSrc)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Warden.isCloseEnoughToInteract(GetPlayerPed(_src), GetPlayerPed(targetSrc)))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_INTERACTION_TOO_FAR)
        return
    end
    _FlashLand.toClient("playerMenu:showIdCard", targetSrc, _src, player.identity)
end)