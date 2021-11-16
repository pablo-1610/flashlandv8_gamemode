--[[
  This file is part of FlashLand.
  Created at 15/11/2021 20:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("showIdCard", function(targetSrc)
    local _src = source
    if (not (_FlashServer_Players.exists(targetSrc))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.TARGET_NO_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    ---@type _Player
    local target = _FlashServer_Players.get(targetSrc)
    -- TODO → Show id card btw
end)