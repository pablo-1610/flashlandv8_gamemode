--[[
  This file is part of FlashLand.
  Created at 12/12/2021 19:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[18] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayerAction ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayerAction]
        perm = "admin.giveweapon"
        for _, weaponData in pairs(_Static_Weapons) do
            RageUI.Button(("%s"):format(weaponData.label), nil, {}, (checkPerm(perm)), {
                onSelected = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:giveWeapon", playerData.sId, weaponData.name)
                end,
            })
        end
    end
end