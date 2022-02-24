--[[
  This file is part of FlashLand.
  Created at 24/02/2022 20:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("orga:givePlayerWeapon", function(organisationName, weaponName)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("orga:givePlayerWeapon sans player (%s)"):format(_src))
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
    if (not (orgaGrade:hasPermission("orga.safeRecoverWeapon"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_ORGANISATION_GRADE_PERMISSION_INVALID_FOR_ACTION)
        player:serverResponded()
        return
    end
    if (not (_Static_Weapons[GetHashKey(weaponName:lower())])) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ADMIN_INVALID_WEAPON)
        player:serverResponded()
        return
    end
    _FlashServer_Loadout.player_addWeapon(_src, weaponName, function(status)
        if (status) then
            orgaData:removeWeapon(weaponName)
            orgaData:saveSafeLoadout()
            _FlashLand.toClient("orga:updateWeapons", _src, orgaData.weapons)
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, _Static_GenericMessages.PLAYER_RECOVER_WEAPON_SUCCESS)
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR)
        end
    end)
    player:serverResponded()
end)