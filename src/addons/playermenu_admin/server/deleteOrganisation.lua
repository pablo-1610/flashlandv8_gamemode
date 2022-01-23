--[[
  This file is part of FlashLand.
  Created at 19/01/2022 22:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:deleteOrganisation", function(organisationName)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:deleteOrganisation sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.deleteOrga"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_ERROR)
        player:serverResponded()
        return
    end
    _FlashServer_Organisation.deleteOrganisation(organisationName, function(status)
        if (status) then
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, _Static_GenericMessages.DELETE_ORGANISATION_SUCCESS)
            _FlashServer_Staff.updateOrganisationForStaff()
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.DELETE_ORGANISATION_ERROR)
        end
    end)
    player:serverResponded()
end)