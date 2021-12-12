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
local teleportType = { _FlashEnum_TELEPORTATIONTYPE.STAFF_ON_PLAYER, _FlashEnum_TELEPORTATIONTYPE.PLAYER_ON_STAFF }
local teleportIndex = 1

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[14] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedReport ~= nil) then
        local reports = _FlashClient_Staff.getReportList()
        local reportData = reports[_FlashClient_PlayerMenu.var.selectedReport]
        RageUI.Separator(("Report de : ~b~%s"):format(reportData.name))
        RageUI.Separator(("Heure du report : ~y~%s"):format(reportData.date))
        RageUI.Separator(("Status du report : %s"):format(statusReport[reportData.status]))
        RageUI.Line()
        if (not (statusBool[reportData.status])) then
            perm = "admin.report"
            RageUI.Button("Prendre le report", ("Raison du report : ~b~%s~s~"):format(reportData.reason), {}, (checkPerm(perm)), {
                onSelected = function()
                    _FlashLand.setIsWaitingForServer(true)
                    reportData.status = 1
                    reportData.moderator = player.name
                    _FlashLand.toServer("staff:takeReport", reportData.sId)
                end,
            })
        else
            RageUI.Separator(("Le report a été prit par : ~r~%s"):format(reportData.moderator))
            RageUI.Line()
            perm = "admin.teleport"
            RageUI.List("Teleportation : ", teleportType, teleportIndex, nil, {}, (checkPerm(perm)), {
                onListChange = function(Index)
                    teleportIndex = Index
                end,
                onSelected = function()
                    if teleportIndex == 1 then
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:teleportStaffToPlayer", reportData.sId)
                    elseif teleportIndex == 2 then
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:teleportPlayerToStaff", reportData.sId)
                    end
                end,
            })
            perm = "admin.giveitem"
            RageUI.Button("Donner un item", nil, { RightLabel = "→" }, (checkPerm(perm)), {
                onSelected = function()
                    _FlashClient_PlayerMenu.var.selectedPlayerAction = reportData.sId
                    _FlashLand.toServer("item:requestLightItems")
                end
            }, _FlashClient_PlayerMenu.getMenus()[17])
            RageUI.Line()
            perm = "admin.kickplayer"
            RageUI.Button("Kick", nil, {}, (checkPerm(perm)), {
                onSelected = function()
                    local reason = _FlashClient_Utils.input_showBox("Raison du kick:", nil, 55, false)
                    if (reason ~= nil) then
                        RageUI.GoBack()
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:kickPlayer", reportData.sId, reason)
                    end
                end,
            })
        end
    end
end