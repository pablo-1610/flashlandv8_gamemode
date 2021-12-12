--[[
  This file is part of FlashLand.
  Created at 11/12/2021 22:50
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:teleportStaffToPlayer", function(targetSource)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:teleportToPlayer sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.teleport"))) then
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
    player:setTeleportPlayer(target:getPlayerPos())
    player:serverResponded()
end)