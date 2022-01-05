--[[
  This file is part of FlashLand.
  Created at 05/01/2022 17:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[19] = function(player)
    local perm = nil
    if (_FlashLand.countTable(_FlashClient_Staff.getBanList()) <= 0) then
        RageUI.Separator("~g~Aucun ~s~ban actif !")
    else
        perm = "admin.ban"
        for key, data in pairs(_FlashClient_Staff.getBanList()) do
            RageUI.Button(("%sBan de : ~b~%s"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), data.name), ("Raison : ~b~%s~s~~n~Jour du ban : ~b~%s~s~~n~Ban par : ~b~%s~s~"):format(data.reason, data.date, data.moderator), { RightLabel = "→" }, (checkPerm(perm)), {
                onSelected = function()
                    _FlashClient_PlayerMenu.var.selectedBan = key
                end,
            }, _FlashClient_PlayerMenu.getMenus()[20])
        end
    end
end