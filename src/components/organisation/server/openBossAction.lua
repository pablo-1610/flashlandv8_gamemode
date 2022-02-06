--[[
  This file is part of FlashLand.
  Created at 06/02/2022 11:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
---@param zone _Zone
_FlashServer_Organisation.openBossAction = function(_src, player, zone, organisation)
    if (not (player)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    if (not (_FlashServer_Zones.exists(zone))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ZONE_NOT_EXISTS)
        return
    end
    if (not (_FlashServer_Organisation.exist(organisation))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ORGANISATION_SELECTED_NOT_EXIST)
        return
    end
    ---@type _Orga
    local orgaData = _FlashServer_Organisation.get(organisation)
    print(player.organisation.orga)
    if (not (player.organisation.orga == orgaData.jobName)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_INVALID:format(orgaData.jobLabel))
        return
    end
    if (not (_FlashServer_Organisation.getGrade(player.organisation.orga, player.organisation.grade.gradeId))) then
        return
    end
    ---@type _OrgaGrade
    local orgaGrade = _FlashServer_Organisation.getGrade(orgaData.jobName, player.organisation.grade.gradeId)
    if (not (orgaGrade:hasPermission("orga.openBossMenu"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        return
    end
    _FlashLand.toClient("organisation:openBossMenu", _src)
end