--[[
  This file is part of FlashLand.
  Created at 12/01/2022 17:21
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:moveBossActionOrganisation", function(organisationName)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:moveBossActionOrganisation sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.moveOrgaPoint"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    ---@type _Orga
    local orga = _FlashServer_Organisation.get(organisationName)
    orga:updateOrgaBossAction(player:getPlayerPos())
    player:serverResponded()
end)