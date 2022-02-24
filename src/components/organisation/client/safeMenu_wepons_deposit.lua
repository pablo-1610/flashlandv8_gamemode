--[[
  This file is part of FlashLand.
  Created at 24/02/2022 20:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Safe.drawer[7] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Safe.intraVars.label))
    if (_FlashLand.countTable(player.inventory.content) <= 0) then
        RageUI.Line()
        RageUI.Separator("~r~Aucune arme sur vous")
    else
        RageUI.Separator(("Nombre d'arme different : ~r~%s"):format(_FlashLand.countTable(player.loadout.content)))
        RageUI.Line()
        RageUI.Separator("~b~↓↓ ~s~ARME(S) ~b~↓↓")
        for _, name in pairs(player.loadout.content) do
            local weaponData = _Static_Weapons[GetHashKey(name:lower())]
            RageUI.Button((("~o~%s"):format(weaponData.label)), nil, {}, (checkPerm("orga.safeDepositWeapon")), {
                onSelected = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("orga:removePlayerWeapon", _FlashClient_Organisation_Safe.intraVars.name, weaponData.name)
                end,
            })
        end
    end
end