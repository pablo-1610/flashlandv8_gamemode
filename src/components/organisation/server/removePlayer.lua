--[[
  This file is part of FlashLand.
  Created at 22/02/2022 19:49

  Copyright (c) FlashLand - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("orga:removePlayer", function(organisationName, flashId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("orga:removePlayer sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
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
    if (not (orgaGrade:hasPermission("orga.bossManageMember"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        return
    end
    _FlashServer_Database.execute("UPDATE flash_players_organisation SET orga = @orga, orga_grade = @orga_grade WHERE flashId = @flashId", {
        ["orga"] = _ConfigServer.Start.organisation,
        ["orga_grade"] = 0,
        ["flashId"] = flashId,
    }, function()
        orgaData:removeMember(flashId)
        _FlashLand.toClient("orga:updateMembers", _src, orgaData.players)
        ---@param target _Player
        for _, target in pairs(_FlashServer_Players.getAll()) do
            if (target.flashId == flashId) then
                target.organisation = { orga = _ConfigServer.Start.organisation, grade = { name = "citoyen", label = "Citoyen", gradeId = 0, permission = {} } }
            end
        end
    end)
    player:serverResponded()
end)