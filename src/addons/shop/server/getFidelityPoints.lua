--[[
  This file is part of FlashLand.
  Created at 12/12/2021 14:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Shops.getFidelityPoints = function(_src, cb)
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Database.query("SELECT * FROM flash_shopsfidelity WHERE owner = @owner", {
        ["owner"] = ("player:%s"):format(player.flashId)
    }, function(result)
        cb(result[1].points)
    end)
end