--[[
  This file is part of FlashLand.
  Created at 12/12/2021 14:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNetExposed("playerDropped", function()
    local _src = source
    ---@type _Player
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    local player = _FlashServer_Players.get(_src)
    ---@type _Report
    if (not (_FlashServer_Reports.exist(_src))) then
        return
    end
    _FlashServer_Reports.remove(_src)
    _FlashServer_Staff.updateReportsForStaff()
end)