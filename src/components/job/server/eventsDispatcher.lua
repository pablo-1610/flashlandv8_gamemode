--[[
  This file is part of FlashLand.
  Created at 30/01/2022 20:00
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("job:outVehicleFromGarage", function(vehicleModel, jobId, selectedOut, zoneId)
    local _src = source
    _FlashServer_Job:outVehicleFromGarage(_src, vehicleModel, jobId, selectedOut, zoneId)
end)