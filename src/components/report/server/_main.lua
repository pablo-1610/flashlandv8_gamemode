--[[
  This file is part of FlashLand.
  Created at 10/12/2021 18:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Reports
_FlashServer_Reports = {}

local list = {}

_FlashServer_Reports.exist = function(reportSource)
    return (list[reportSource] ~= nil)
end

_FlashServer_Reports.get = function(reportSource)
    if (not (_FlashServer_Reports.exist(reportSource))) then
        return nil
    end
    return (list[reportSource])
end

_FlashServer_Reports.getAll = function()
    return (list)
end

---@param report _Report
_FlashServer_Reports.add = function(report)
    _FlashLand.log(("^2Ajout ^7d'un ^6REPORT ^7id: ^3%s"):format(report.source))
    list[report.sId] = report
end

_FlashServer_Reports.remove = function(reportSource)
    _FlashLand.log(("^1Suppression ^7d'un ^6REPORT ^7id: ^3%s"):format(list[reportSource].source))
    list[reportSource] = nil
end

_FlashLand.loadedComponent("report")