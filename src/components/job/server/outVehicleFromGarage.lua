--[[
  This file is part of FlashLand.
  Created at 30/01/2022 20:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

function _FlashServer_Job:outVehicleFromGarage(_src, vehicleModel, jobId, selectedOut, zoneId)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Job:exists(jobId))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.JOB_NOT_EXISTS)
        return
    end
    ---@type _Job
    local job = _FlashServer_Job:get(jobId)
    if (player.job._job.id ~= jobId) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.WRONG_JOB)
        return
    end
    local vehData = job:getMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS)
    local out = vehData.zones[zoneId].outPossibilities[selectedOut]
    if (not (out)) then
        _FlashLand.err("Out vehicle from garage: Out possibility not found")
        player:serverResponded()
        return
    end
    local veh = CreateVehicle(vehicleModel, out.x, out.y, out.z, vehData.zones[zoneId].outHeading, true, true)
    player:serverResponded()
end