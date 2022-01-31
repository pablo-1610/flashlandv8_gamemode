--[[
  This file is part of FlashLand.
  Created at 31/01/2022 19:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:removePermissionForOrganisationGrade", function(organisationName, gradeId, permission)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:removePermissionForOrganisationGrade sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.managePermissionOrganisationGrade"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.gradeExist(organisationName, gradeId))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_GRADE_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.permissionExist(permission))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PERMISSION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    ---@type _OrgaGrade
    local organisationGrade = _FlashServer_Organisation.getGrade(organisationName, gradeId)
    organisationGrade:deletePermission(permission)
    _FlashServer_Staff.updateOrganisationForStaff()
    player:serverResponded()
end)