--[[
  This file is part of FlashLand.
  Created at 10/12/2021 21:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Blips.createPublicInArea = function(position, sprite, color, size, label, shortRange, drawDist)
    local id = _FlashServer_Blips.getNextId()
    local blip = _Blip(id, position, sprite, color, size, label, shortRange, drawDist, false)
    _FlashServer_Blips.add(blip)
    return (id)
end