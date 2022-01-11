--[[
  This file is part of FlashLand.
  Created at 11/01/2022 20:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.getLightOrganisation = function(orgaId)
    ---@type _Orga
    local organisation = _FlashServer_Organisation.get(orgaId)
    ---@type _LightOrga
    return (_LightOrga(organisation.jobName, organisation.jobLabel, organisation.grade, organisation.bossPos, organisation.safePos, organisation.spawnVehiclePos, organisation.delVehiclePos, organisation.blip, organisation.allowed))
end