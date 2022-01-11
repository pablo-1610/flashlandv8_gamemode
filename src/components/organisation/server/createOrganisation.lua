--[[
  This file is part of FlashLand.
  Created at 11/01/2022 18:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.createOrganisation = function(job, grade, bossPos, safePos, spawnVehiclePos, delVehiclePos, blipPos, blipName, blipId, blipColor, allowed)
    ---@type _Orga
    local orga = _Orga(_FlashServer_Organisation.getNextId(), job, grade, bossPos, safePos, spawnVehiclePos, delVehiclePos, blipPos, blipName, blipId, blipColor, allowed)
    _FlashServer_Organisation.add(orga)
    return (orga)
end