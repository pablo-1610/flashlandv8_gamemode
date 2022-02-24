--[[
  This file is part of FlashLand.
  Created at 19/02/2022 11:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashServer_Commands.registerCommandBasic("report", function(source, player, args)
    if (_FlashServer_Reports.exist(source)) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_REPORT_ACTIVE)
        return
    end
    ---@type _Report
    local report = _Report(source, player.name, table.concat(args, " "))
    _FlashServer_Reports.add(report)
    _FlashServer_Staff.updateReportsForStaff()
end)