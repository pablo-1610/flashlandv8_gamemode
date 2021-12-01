--[[
  This file is part of FlashLand.
  Created at 01/12/2021 14:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local function isWeaponValid(modelName)
    local hashed = GetHashKey(modelName)
    for hash, weaponData in pairs(_Static_Weapons) do
        if (hash == hashed) then
            return (true)
        end
    end
    return (false)
end

_FlashServer_Commands.registerPermissionCommand("giveweapon", "admin.giveweapon", function(isPlayer, args, player, cbMesage)
    local targetId = tonumber(args[1])
    local weaponName = args[2]:lower()
    if (not (targetId)) then
        cbMesage(false, _Static_GenericMessages.ADMIN_INVALID_ID)
        return
    end
    if (not (_FlashServer_Players.exists(targetId))) then
        cbMesage(false, _Static_GenericMessages.ADMIN_OFFLINE_PLAYER)
        return
    end
    local target = _FlashServer_Players.get(targetId)
    if (not (isWeaponValid(weaponName))) then
        cbMesage(false, _Static_GenericMessages.ADMIN_INVALID_WEAPON)
        return
    end
    _FlashServer_Loadout.player_addWeapon(targetId, weaponName ,function(success)
        if (success) then
            cbMesage(true, _Static_GenericMessages.ADMIN_ACTION_PERFORMED)
            return
        else
            cbMesage(false, _Static_GenericMessages.ADMIN_ACTION_FAILED)
            return
        end
    end)
end, {"id", "weapon_name"})