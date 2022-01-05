--[[
  This file is part of FlashLand.
  Created at 03/01/2022 18:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNetExposed("playerConnecting", function(playerName, setKickReason, deferrals)
    local _src = source
    local identifier = _FlashServer_Utils.identifiers_get(_src, "license")
    deferrals.update(_FlashEnum_PLAYER_CONNECT.PLAYER_CHECK_IS_BAN)
    Wait(2500)
    for banIdentifier, data in pairs(_FlashServer_Bans.getAll()) do
        if (banIdentifier == identifier) then
            deferrals.done((_FlashEnum_PLAYER_CONNECT.PLAYER_IS_BAN):format(data.date, data.reason, data.moderator))
        end
    end
    deferrals.done()
end)