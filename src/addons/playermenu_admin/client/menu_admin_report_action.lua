--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:08
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local statusReport = { [0] = _FlashEnum_ADMINREPORTACTION.REPORT_NOT_MANAGE, [1] = _FlashEnum_ADMINREPORTACTION.REPORT_MANAGE }
local statusBool = { [0] = false, [1] = true }

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[14] = function(player)
    local reportData = _FlashClient_PlayerMenu.var.selectedReport
    RageUI.Separator(("Report de : ~b~%s"):format(reportData.name))
    RageUI.Separator(("Heure du report : ~y~%s"):format(reportData.date))
    RageUI.Separator(("Status du report : %s"):format(statusReport[reportData.status]))
    RageUI.Line()
    if (not (statusBool[reportData.status])) then
        RageUI.Button("Prendre le report", ("Raison du report : ~b~%s~s~"):format(reportData.reason), {}, (checkPerm("admin.report")), {
            onSelected = function()
                reportData.status = 1
                reportData.moderator = player.name
                _FlashLand.toServer("staff:takeReport", reportData.source)
            end,
        })
    else
        RageUI.Separator(("Le report a été prit par : ~r~%s"):format(reportData.moderator))
        RageUI.Line()
        RageUI.Button("Test Button", nil, {}, (checkPerm("admin.report")), {})
        RageUI.Button("Test Button", nil, {}, (checkPerm("admin.report")), {})
        RageUI.Button("Test Button", nil, {}, (checkPerm("admin.report")), {})
    end
end