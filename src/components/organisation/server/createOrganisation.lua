--[[
  This file is part of FlashLand.
  Created at 11/01/2022 18:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.createOrganisation = function(jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blip)
    ---@type _Orga
    local orga = _Orga(jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blip)
    _FlashServer_Organisation.add(orga)
    _FlashServer_Organisation.loadGrade()
    return (orga)
end