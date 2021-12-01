--[[
  This file is part of FlashLand.
  Created at 01/12/2021 15:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local function hasWeapon(table, weapon)
    for k, v in pairs(table) do
        if (v == weapon) then
            return (true)
        end
    end
    return (false)
end

---@param lightPlayerOld _LightPlayer
---@param lightPlayer _LightPlayer
_FlashLand.onReceiveWithoutNet("spawn:handleNewLoadout", function(lightPlayerOld, lightPlayer)
    local newLoadout = lightPlayer.loadout.content
    -- First init
    if (lightPlayerOld == nil) then
        RemoveAllPedWeapons(PlayerPedId())
        for _, weaponName in pairs(newLoadout) do
            local weaponHash = GetHashKey(weaponName)
            GiveWeaponToPed(PlayerPedId(), weaponHash, 0, false, false)
        end
        return
    end
    local oldLoadout = lightPlayerOld.loadout.content

    for _, oldWeapon in pairs(oldLoadout) do
        if (not (hasWeapon(newLoadout, oldWeapon))) then
            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(oldWeapon))
        end
    end

    for _, newWeapon in pairs(newLoadout) do
        if (not (hasWeapon(oldLoadout, newWeapon))) then
            GiveWeaponToPed(PlayerPedId(), GetHashKey(newWeapon), 0, false, false)
        end
    end
end)