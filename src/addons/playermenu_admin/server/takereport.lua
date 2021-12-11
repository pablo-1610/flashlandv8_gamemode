--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function takeReportToAllStaff(playerName, staffName)
    for _src, _ in pairs(_FlashServer_Staff.getAllStaffInService()) do
        _FlashServer_Staff.getNotifyAllStaffInService((_Static_GenericMessages.ALL_MESSAGE_STAFF_TAKE_REPORT):format(staffName, playerName))
    end
end

_FlashLand.onReceive("staff:takeReport", function(reportSource)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:takeReport sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.report"))) then
        player:sendSystemMessage("error", _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        return
    end
    ---@type _Report
    local report = _FlashServer_Reports.get(reportSource)
    report:updateStatus()
    report:setModerator(player:getName())
    takeReportToAllStaff(report:getPlayerName(), report:getStaffName())
end)