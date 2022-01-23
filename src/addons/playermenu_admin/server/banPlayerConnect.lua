--[[
  This file is part of FlashLand.
  Created at 05/01/2022 19:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:banPlayerConnect", function(targetSource, day, reason)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:kickPlayer sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.ban"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_SELECTED_IS_INVALID)
        player:serverResponded()
        return
    end
    _FlashServer_Bans.addPlayerBan(targetSource, day, reason, player:getName(), function(succes)
        if (succes) then
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, _Static_GenericMessages.BAN_SUCCES)
            _FlashServer_Staff.updateBansForStaff()
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.BAN_ERROR)
        end
    end)
    player:serverResponded()
end)