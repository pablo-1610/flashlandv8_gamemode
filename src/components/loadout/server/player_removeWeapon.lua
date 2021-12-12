--[[
  This file is part of FlashLand.
  Created at 12/12/2021 18:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function isWeaponValid(modelName)
    local hashed = GetHashKey(modelName)
    for hash, weaponData in pairs(_Static_Weapons) do
        if (hash == hashed) then
            return (true)
        end
    end
    return (false)
end

_FlashServer_Loadout.player_removeWeapon = function(_src, weaponName, cb)
    local weaponHash = GetHashKey(weaponName)
    if (not (isWeaponValid(weaponName))) then
        _FlashLand.err(("Removeweapon avec model invalide (%s/%s)"):format(_src, weaponName))
        cb(false)
        return
    end
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("Removeweapon sur un id invalide (%s)"):format(_src))
        cb(false)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    ---@type _Loadout
    local loadout = player.loadout
    if (not (loadout:hasWeapon(weaponName))) then
        cb(false)
        return
    end
    loadout:removeWeapon(weaponName)
    player:sendData()
    cb(true)
end