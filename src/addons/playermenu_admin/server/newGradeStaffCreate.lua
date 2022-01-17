--[[
  This file is part of FlashLand.
  Created at 14/01/2022 13:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:newGradeStaffCreate", function(newRole)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:newGradeStaffCreate sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.createGroup"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (_FlashServer_Ranks.exists(newRole.name)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.RANK_SELECTED_EXIST)
        player:serverResponded()
        return
    end
    if (not (_Config.Color[newRole.color])) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.COLOR_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    local color = _Config.Color[newRole.color].color
    _FlashServer_Ranks.create(newRole.name, newRole.label, newRole.position, newRole.weight, color, newRole.permissions)
    _FlashLand.toClient("staff:cbRankList", _src, _FlashServer_Ranks.getAllRank())
    player:serverResponded()
end)