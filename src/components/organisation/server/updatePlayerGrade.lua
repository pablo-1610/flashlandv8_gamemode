--[[
  This file is part of FlashLand.
  Created at 22/02/2022 20:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("orga:updatePlayerGrade", function(organisationName, flashId, gradeId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("orga:updatePlayerGrade sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    ---@type _Orga
    local orgaData = _FlashServer_Organisation.get(organisationName)
    if (not (player.organisation.orga == orgaData.jobName)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_INVALID:format(orgaData.jobLabel))
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.gradeExist(player.organisation.orga, player.organisation.grade.gradeId))) then
        player:serverResponded()
        return
    end
    ---@type _OrgaGrade
    local orgaGrade = _FlashServer_Organisation.getGrade(player.organisation.orga, player.organisation.grade.gradeId)
    if (not (orgaGrade:hasPermission("orga.bossManageMember"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.gradeExist(organisationName, gradeId))) then
        player:serverResponded()
        return
    end
    ---@type _OrgaGrade
    local newGrade = _FlashServer_Organisation.getGrade(organisationName, gradeId)
    _FlashServer_Database.execute("UPDATE flash_players_organisation SET orga_grade = @orga_grade WHERE flashId = @flashId", {
        ["orga_grade"] = newGrade.gradeId,
        ["flashId"] = flashId,
    }, function()
        orgaData:updatePlayerGrade(flashId, _FlashServer_Organisation.getGrade(organisationName, gradeId))
        _FlashLand.toClient("orga:updateMembers", _src, orgaData.players)
        ---@param target _Player
        for _, target in pairs(_FlashServer_Players.getAll()) do
            if (target.flashId == flashId) then
                target.organisation.grade.name = newGrade.gradeName
                target.organisation.grade.label = newGrade.gradeLabel
                target.organisation.grade.gradeId = newGrade.gradeId
                target.organisation.grade.permission = newGrade.permissions
                target:sendData()
            end
        end
    end)
    player:serverResponded()
end)