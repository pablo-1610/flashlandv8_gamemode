--[[
  This file is part of FlashLand.
  Created at 17/01/2022 18:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:createNewOrganisation", function(organisationData)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:createNewOrganisation sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.createOrganisation"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (_FlashServer_Organisation.exist(organisationData.name)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_EXIST)
        player:serverResponded()
        return
    end
    _FlashServer_Organisation.createOrganisation(organisationData.name, organisationData.label, organisationData.bossPos, organisationData.safePos, organisationData.spawnVehiclePos, organisationData.delVehiclePos, organisationData.blip)
    _FlashServer_Staff.updateOrganisationForStaff()
    player:serverResponded()
end)