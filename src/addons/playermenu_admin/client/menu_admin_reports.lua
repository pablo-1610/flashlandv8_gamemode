--[[
  This file is part of FlashLand.
  Created at 10/12/2021 19:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

local statusReport = { [0] = _FlashEnum_ADMINREPORTACTION.REPORT_NOT_MANAGE, [1] = _FlashEnum_ADMINREPORTACTION.REPORT_MANAGE }

---@param player _Player
_FlashClient_PlayerMenu.drawer[13] = function(player)
    local perm = nil
    if (_FlashLand.countTable(_FlashClient_Staff.getReportList()) <= 0) then
        RageUI.Separator("~g~Aucun ~s~report actif !")
    else
        perm = "admin.report"
        for key, data in pairs(_FlashClient_Staff.getReportList()) do
            RageUI.Button(("%sReport de : ~b~%s"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), data.name), ("Raison : ~b~%s~s~~n~Heure du report : ~b~%s~s~~n~Status : %s"):format(data.reason, data.date, statusReport[data.status]), {}, (checkPerm("admin.report")), {
                onSelected = function()
                    _FlashClient_PlayerMenu.var.selectedReport = key
                end,
            }, _FlashClient_PlayerMenu.getMenus()[14])
        end
    end
end