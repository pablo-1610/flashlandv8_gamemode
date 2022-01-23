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
    deferrals.update(_FlashEnum_BAN.PLAYER_CHECK_IS_BAN)
    Wait(2500)
    if (_FlashServer_Bans.exist(identifier)) then
        ---@type _Ban
        local ban = _FlashServer_Bans.get(identifier)
        deferrals.done((_FlashEnum_BAN.PLAYER_BAN):format(ban.reason, ban.date, ban.time, ban.moderator))
    end
    deferrals.done()
end)