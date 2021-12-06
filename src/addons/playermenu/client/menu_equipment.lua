--[[
  This file is part of FlashLand.
  Created at 20/11/2021 16:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_PlayerMenu.drawer[12] = function(player)
    -- TODO → Throwable
    for _, name in pairs(player.loadout.content) do
        local weaponData = _Static_Weapons[GetHashKey(name:lower())]
        RageUI.Button(("~s~%s"):format(weaponData.label), nil, { RightLabel = "→"}, true, {
            onSelected = function()
                _FlashClient_PlayerMenu.var.selectedWeapon = name
            end
        })
    end
end