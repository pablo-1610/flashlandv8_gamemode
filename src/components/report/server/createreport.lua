--[[
  This file is part of FlashLand.
  Created at 10/12/2021 18:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashServer_Reports.createReport = function(playerSource, reason)
    if (playerSource == 0) then
        return
    end
    if (_FlashServer_Players.exists(playerSource)) then
        ---@type _Player
        local player = _FlashServer_Players.get(playerSource)
        if (_FlashServer_Reports.exist(playerSource)) then
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, ("%s"):format(_Static_GenericMessages.PLAYER_REPORT_ACTIVE))
            return
        end
        if (not (reason ~= nil)) then
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, ("%s"):format(_Static_GenericMessages.PLAYER_REPORT_REASON_NIL))
            return
        end
        ---@type _Report
        local report = _Report(playerSource, player:getName(), reason, "test")
        _FlashServer_Reports.add(report)
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, ("%s"):format(_Static_GenericMessages.PLAYER_SEND_REPORT_SUCCESS))
        _FlashServer_Staff.updateReportsForStaff()
        _FlashServer_Staff.getNotifyAllStaffInService((_Static_GenericMessages.NOTIFY_ALL_STAFF_NEW_REPORT):format(report:getPlayerName()))
    end
end