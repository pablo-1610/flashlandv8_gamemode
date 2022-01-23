--[[
  This file is part of FlashLand.
  Created at 12/01/2022 19:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:addPermissionForRank", function(rankId, permission)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:addPermissionForRank sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.accessRankManagerAndManageRank"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Ranks.get(rankId))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.RANK_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Ranks.permissionExist(permission))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PERMISSION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    ---@type _Rank
    local rank = _FlashServer_Ranks.get(rankId)
    rank:newPermission(permission)
    _FlashLand.toClient("staff:cbRankList", _src, _FlashServer_Ranks.getAllRank())
    for allPlayersSource, _ in pairs(_FlashServer_Players.getAll()) do
        ---@type _Player
        local target = _FlashServer_Players.get(allPlayersSource)
        target:sendData()
    end
    player:serverResponded()
end)