--[[
  This file is part of FlashLand.
  Created at 19/02/2022 13:14
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("orga:newGrade", function(organisationName, grade)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("orga:addPermissionForOrganisationGrade sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        return
    end
    if (_FlashServer_Organisation.gradeExist(organisationName, grade.id)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.GRADE_EXIST)
        return
    end
    ---@type _Orga
    local orgaData = _FlashServer_Organisation.get(organisationName)
    if (not (player.organisation.orga == orgaData.jobName)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_INVALID:format(orgaData.jobLabel))
        return
    end
    if (not (_FlashServer_Organisation.gradeExist(player.organisation.orga, player.organisation.grade.gradeId))) then
        return
    end
    ---@type _OrgaGrade
    local orgaGrade = _FlashServer_Organisation.getGrade(player.organisation.orga, player.organisation.grade.gradeId)
    if (not (orgaGrade:hasPermission("orga.createGrade"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        return
    end
    ---@param newGrade _OrgaGrade
    _FlashServer_Organisation.createGrade(organisationName, grade.id, grade.name, grade.label, function(status, newGrade)
        if (status) then
            for _, permission in pairs(grade.permissions) do
                newGrade:addPermission(permission)
            end
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, _Static_GenericMessages.ORGANISATION_GRADES_CREATE)
            _FlashLand.toClient("orga:updateGrade", _src, orgaData.grade)
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_GRADES_ERROR)
        end
    end)
    player:serverResponded()
end)