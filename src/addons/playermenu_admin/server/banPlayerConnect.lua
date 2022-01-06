--[[
  This file is part of FlashLand.
  Created at 05/01/2022 19:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:banPlayerConnect", function(targetSource, reason)
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
    ---@type _Player
    local target = _FlashServer_Players.get(targetSource)
    _FlashServer_Bans.addBan(target.identifier, target:getName(), player:getName(), reason)
    DropPlayer(targetSource, (_Static_GenericMessages.STAFF_BAN_PLAYER):format(player:getName(), reason))
    _FlashServer_Staff.updateBansForStaff()
    player:serverResponded()
end)