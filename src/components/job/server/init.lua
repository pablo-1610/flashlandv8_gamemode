--[[
  This file is part of FlashLand.
  Created at 29/01/2022 22:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param job _Job
local function initializeJob(job)
    -- Initialize job's public blip
    if (job:metadataExists(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)) then
        local blipData = job:getMetadata(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)
        _FlashServer_Blips.createPublic(blipData.position, blipData.sprite, blipData.color, _Config.genericBlipSize, blipData.name, blipData.shortRange)
    end

    -- Initialize job's parkings
    if (job:metadataExists(_FlashEnum_JOBMETADATA.VEHICLES_INFOS)) then
        local vehicleInfos = job:getMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS)
        for k, v in pairs(vehicleInfos.zones) do
            -- Init garage menu
            for _, v in pairs(v.garageMenu) do
                ---@type _Zone
                local zone = _FlashServer_Zones.createRestricted(v, {255,255,255}, function(_src, player)
                    print(("%s open menu"):format(_src))
                end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 10.0, 1.0, true)
                job:addRestrictedZone(zone)

                ---@type _Blip
                local blip = _FlashServer_Blips.createRestricted(v, 357, 74, _Config.genericSubBlipSize, "Garage", true)
                job:addRestrictedBlip(blip)
            end
        end
    end
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    for jobId, job in pairs(_FlashServer_Job:getAll()) do
        initializeJob(job)
    end
end)