--[[
  This file is part of FlashLand.
  Created at 13/12/2021 23:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function closeReportToAllStaff(playerName, staffName)
    for _src, _ in pairs(_FlashServer_Staff.getAllStaffInService()) do
        _FlashServer_Staff.getNotifyAllStaffInService((_Static_GenericMessages.ALL_MESSAGE_STAFF_REMOVE_REPORT):format(staffName, playerName))
    end
end

_FlashLand.onReceive("staff:closeReport", function(reportSource)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:closeReport sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.report"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Reports.exist(reportSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.REPORT_SOURCE_NOT_EXIST)
        player:serverResponded()
        return
    end
    ---@type _Report
    local report = _FlashServer_Reports.get(reportSource)
    closeReportToAllStaff(report:getPlayerName(), player:getName())
    _FlashServer_Reports.remove(reportSource)
    _FlashServer_Staff.updateReportsForStaff()
    player:serverResponded()
end)