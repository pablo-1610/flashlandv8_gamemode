--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Zones.createPublic = function(location, color, onInteract, helpText, drawDist, itrDist)
    local id = _FlashServer_Zones.getNextId()
    local zone = _Zone(id, location, color, onInteract, helpText, drawDist, itrDist)
    _FlashServer_Zones.add(zone)
    return (id)
end