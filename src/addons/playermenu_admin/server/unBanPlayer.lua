--[[
  This file is part of FlashLand.
  Created at 05/01/2022 18:54
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:unBanPlayer", function(banIdentifier)
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
    if (not (_FlashServer_Bans.exist(banIdentifier))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.BAN_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    _FlashServer_Bans.remove(banIdentifier)
    _FlashServer_Staff.updateBansForStaff()
    player:serverResponded()
end)