--[[
  This file is part of FlashLand.
  Created at 30/01/2022 12:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Zones.createRestricted = function(location, color, onInteract, helpText, drawDist, itrDist, hideIfAMenuIsOpen, headingCorrection, jobRequired)
    local id = _FlashServer_Zones.getNextId()
    local zone = _Zone(id, location, color, onInteract, helpText, drawDist, itrDist, true, hideIfAMenuIsOpen, headingCorrection, jobRequired)
    _FlashServer_Zones.add(zone)
    return (zone)
end