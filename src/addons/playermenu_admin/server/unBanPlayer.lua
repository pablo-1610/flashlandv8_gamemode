--[[
  This file is part of FlashLand.
  Created at 05/01/2022 18:54
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:unBanPlayer", function(identifier)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:unBanPlayer sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.unban"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Bans.exist(identifier))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.BAN_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    _FlashServer_Bans.removePlayerBan(identifier, function(succes)
        if (succes) then
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, _Static_GenericMessages.UNBAN_SUCCES)
            _FlashServer_Staff.updateBansForStaff()
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.UNBAN_ERROR)
        end
    end)
    player:serverResponded()
end)