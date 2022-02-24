--[[
  This file is part of FlashLand.
  Created at 06/02/2022 11:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
---@param zone _Zone
_FlashServer_Organisation.rangeVehicle = function(_src, player, zone, organisation)
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
        player:serverResponded()
        return
    end
    ---@type _Orga
    local orgaData = _FlashServer_Organisation.get(organisation)
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
    local orgaGrade = _FlashServer_Organisation.getGrade(orgaData.jobName, player.organisation.grade.gradeId)
    if (not (orgaGrade:hasPermission("orga.delVehicle"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        player:serverResponded()
        return
    end
    _FlashLand.toClient("organisation:deleteVehicle", _src)
end