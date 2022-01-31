--[[
  This file is part of FlashLand.
  Created at 30/01/2022 12:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Blips.createRestricted = function(position, sprite, color, size, label, shortRange)
    local id = _FlashServer_Blips.getNextId()
    local blip = _Blip(id, position, sprite, color, size, label, shortRange, 0, true)
    _FlashServer_Blips.add(blip)
    return (blip)
end