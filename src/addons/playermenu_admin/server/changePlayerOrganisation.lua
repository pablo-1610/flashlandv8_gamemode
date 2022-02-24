--[[
  This file is part of FlashLand.
  Created at 24/02/2022 18:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:changePlayerOrganisation", function(targetSource, organisationName, gradeId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:changePlayerOrganisation sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.changeOrga"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ADMIN_OFFLINE_PLAYER)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Organisation.gradeExist(organisationName, gradeId))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_GRADES_ERROR)
        player:serverResponded()
        return
    end
    ---@type _Player
    local xTarget = _FlashServer_Players.get(targetSource)
    if (xTarget.organisation.orga ~= organisationName) then
        ---@type _Orga
        local lastOrga = _FlashServer_Organisation.get(xTarget.organisation.orga)
        lastOrga:removeMember(xTarget.flashId)
    end
    ---@type _Orga
    local orgaData = _FlashServer_Organisation.get(organisationName)
    ---@type _OrgaGrade
    local newGrade = _FlashServer_Organisation.getGrade(organisationName, gradeId)
    xTarget:updateOrganisation(organisationName, newGrade.gradeName, newGrade.gradeLabel, newGrade.gradeId, newGrade.permissions)
    xTarget:sendData()
    if (orgaData:getMember(xTarget.flashId)) then
        orgaData:updatePlayerGrade(xTarget.flashId, newGrade)
    else
        local playerData = {}
        playerData[xTarget.flashId] = { name = xTarget:getRpIdentity(), flashId = xTarget.flashId, grade = _FlashServer_Organisation.getGrade(xTarget.organisation.orga, xTarget.organisation.orga_grade) }
        orgaData:addNewMember(playerData[xTarget.flashId])
    end
    _FlashServer_Staff.updatePlayersForStaff()
    player:serverResponded()
end)