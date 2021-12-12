--[[
  This file is part of FlashLand.
  Created at 12/12/2021 14:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Shops.createFidelity = function(_src)
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Database.insert("INSERT INTO flash_shopsfidelity (owner) VALUES(@owner)", {
        ["@owner"] = ("player:%i"):format(player.flashId)
    })
end