--[[
  This file is part of FlashLand.
  Created at 01/02/2022 21:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Job_ArmoryMenu.drawer[1] = function(player)
    for _, weapon in pairs(_FlashClient_Job_ArmoryMenu.intraVars.weapons) do
        local weaponName = _Static_Weapons[GetHashKey(weapon)] and _Static_Weapons[GetHashKey(weapon)].label or weapon:lower()
        RageUI.Button(weaponName, nil, {RightLabel = "~r~Prendre ~s~→"}, true, {
            onSelected = function()
                _FlashLand.toServer("job:outWeaponFromArmory", _FlashClient_Job_ArmoryMenu.intraVars.jobId, weapon:lower())
            end
        })
    end
end