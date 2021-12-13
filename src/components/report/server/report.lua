--[[
  This file is part of FlashLand.
  Created at 10/12/2021 18:38
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param report _Report
_FlashServer_Players.getReport = function(reportSource)
    ---@type _Report
    local report = _FlashServer_Reports.get(reportSource)
    return (_Report(report.sId, report.name, report.reason, report.status, report.moderatorId, report.moderator))
end