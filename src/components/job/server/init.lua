--[[
  This file is part of FlashLand.
  Created at 29/01/2022 22:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local prefix = "[Métier]"

---@param job _Job
local function retrieveVehicles(job)
    local id = job.id
    if (not (_FlashServer_Utils.file_exists(("resources/flashland/src/jobs/%s/vehicles.json"):format(id)))) then
        local vehicles = job:metadataExists(_FlashEnum_JOBMETADATA.VEHICLES_INFOS) and job:getMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS).defaultVehicles or {}
        CreateThread(function()
            _FlashServer_Utils.file_write(("resources/flashland/src/jobs/%s/vehicles.json"):format(id), json.encode(vehicles))
        end)
        return vehicles
    else
        local vehicles = _FlashServer_Utils.file_read(("resources/flashland/src/jobs/%s/vehicles.json"):format(id))
        return json.decode(vehicles)
    end
end

---@param job _Job
local function initializeJobs(job)
    -- Retrieve and init vehicles
    job.vehicles = retrieveVehicles(job)

    -- Initialize job's public blip
    if (job:metadataExists(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)) then
        local blips = job:getMetadata(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)
        for _, blipData in pairs(blips) do
            _FlashServer_Blips.createPublic(blipData.position, blipData.sprite, blipData.color, _Config.genericBlipSize, blipData.name, blipData.shortRange)
        end
    end

    -- Initialize job's employees blip
    if (job:metadataExists(_FlashEnum_JOBMETADATA.EMPLOYEE_BLIP)) then
        local blips = job:getMetadata(_FlashEnum_JOBMETADATA.EMPLOYEE_BLIP)
        for _, blipData in pairs(blips) do
            ---@type _Blip
            local blip = _FlashServer_Blips.createRestricted(blipData.position, blipData.sprite, blipData.color, _Config.genericBlipSize, blipData.name, blipData.shortRange)
            job:addRestrictedBlip(blip)
        end
    end

    -- Initialize job's parkings
    if (job:metadataExists(_FlashEnum_JOBMETADATA.VEHICLES_INFOS)) then
        local vehicleInfos = job:getMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS)
        for zoneId, zoneData in pairs(vehicleInfos.zones) do
            -- Init garage menu
            for _, v in pairs(zoneData.garageMenu) do
                ---@type _Zone
                local zone = _FlashServer_Zones.createRestricted(v, { 255, 255, 255 }, function(_src, player)
                    _FlashServer_Job:openVehicleMenu(_src, player, job, zoneData.outPossibilities, zoneId)
                end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 10.0, 1.0, true)
                job:addRestrictedZone(zone)
                ---@type _Blip
                local blip = _FlashServer_Blips.createRestricted(v, 357, 17, _Config.genericSubBlipSize, ("%s Garage"):format(prefix), true)
                job:addRestrictedBlip(blip)
            end

            for _, v in pairs(zoneData.backZones) do
                ---@type _Zone
                local zone = _FlashServer_Zones.createRestricted(v, { 255, 117, 117 }, function(_src, player)
                    -- TODO → Back zones
                end, "Appuyez sur ~INPUT_CONTEXT~ pour rentrer un véhicule dans le garage", 10.0, 2.35, true)
                zone:addFlag(_FlashEnum_ZONEFLAG.INTERACT_ONLY_IF_IS_VEHICLE_DRIVER)
                job:addRestrictedZone(zone)

                ---@type _Blip
                local blip = _FlashServer_Blips.createRestricted(v, 225, 6, _Config.genericSubBlipSize - 0.2, ("%s Retour véhicule"):format(prefix), true)
                job:addRestrictedBlip(blip)
            end
        end
    end

    -- Initialize job's cloakrooms
    if (job:metadataExists(_FlashEnum_JOBMETADATA.CLOAKROOM_INFO)) then
        local cloakrooms = job:getMetadata(_FlashEnum_JOBMETADATA.CLOAKROOM_INFO)
        for _, v in pairs(cloakrooms.zones) do
            ---@type _Zone
            local zone = _FlashServer_Zones.createRestricted(v, { 255, 255, 255 }, function(_src, player)
                -- TODO → Cloakroom
            end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire", 10.0, 1.0, true)
            job:addRestrictedZone(zone)

            ---@type _Blip
            local blip = _FlashServer_Blips.createRestricted(v, 73, 17, _Config.genericSubBlipSize, ("%s Vestiaire"):format(prefix), true)
            job:addRestrictedBlip(blip)
        end
    end

    -- Initialize job's boss
    if (job:metadataExists(_FlashEnum_JOBMETADATA.BOSS_INFOS)) then
        local boss = job:getMetadata(_FlashEnum_JOBMETADATA.BOSS_INFOS)
        for _, v in pairs(boss.zones) do
            ---@type _Zone
            local zone = _FlashServer_Zones.createRestricted(v, { 255, 255, 255 }, function(_src, player)
                -- TODO → Boss management
            end, ("Appuyez sur ~INPUT_CONTEXT~ pour gérer: ~b~%s"):format(job.label), 10.0, 1.0, true)
            zone:addFlag(_FlashEnum_ZONEFLAG.INTERACT_ONLY_IF_IS_BOSS)
            job:addRestrictedZone(zone)

            ---@type _Blip
            local blip = _FlashServer_Blips.createRestricted(v, 171, 17, _Config.genericSubBlipSize, ("%s Gestion"):format(prefix), true)
            job:addRestrictedBlip(blip)
        end
    end

    -- Initialize job's static ped
    if (job:metadataExists(_FlashEnum_JOBMETADATA.STATIC_PED)) then
        local staticPedList = job:getMetadata(_FlashEnum_JOBMETADATA.STATIC_PED)
        for _, v in pairs(staticPedList) do
            ---@type _Npc
            local npc = _FlashServer_Npc.create(v.position, v.heading, v.model, false, true, 30.0)
            npc:setScenario(v.scenario, true)
        end
    end

    -- Initialize job's local data
    if (job:metadataExists(_FlashEnum_JOBMETADATA.LOCAL_DATA)) then
        local localDataList = job:getMetadata(_FlashEnum_JOBMETADATA.LOCAL_DATA)
        for _, localData in pairs(localDataList) do
            job:setupLocalData(localData.id)
        end
    end
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    for _, job in pairs(_FlashServer_Job:getAll()) do
        initializeJobs(job)
    end
end)