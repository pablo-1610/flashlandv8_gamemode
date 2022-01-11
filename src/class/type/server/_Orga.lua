--[[
  This file is part of FlashLand.
  Created at 11/01/2022 17:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _Orga
_Orga = {}
_Orga.__index = _Orga

setmetatable(_Orga, {
    __call = function(_, jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blip, allowed)
        local self = setmetatable({}, _Orga)
        self.jobName = jobName
        self.jobLabel = jobLabel
        self.grade = {}
        _FlashServer_Organisation.loadGrade()
        self.bossPos = _FlashServer_Zones.createPublic(vector3(bossPos.x, bossPos.y, bossPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour gérer votre organisation", 20.0, 1.0, true, 180.0)
        self.safePos = _FlashServer_Zones.createPublic(vector3(safePos.x, safePos.y, safePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre", 20.0, 1.0, true, 180.0)
        self.safePos = _FlashServer_Zones.createPublic(vector3(spawnVehiclePos.x, spawnVehiclePos.y, spawnVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 20.0, 1.0, true, 180.0)
        self.safePos = _FlashServer_Zones.createPublic(vector3(delVehiclePos.x, delVehiclePos.y, delVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule", 20.0, 1.0, true, 180.0)
        self.blip = _FlashServer_Blips.createPublic(vector3(blip.pos.x, blip.pos.y, blip.pos.z), blip.id, blip.color, _Config.genericBlipSize, blip.name, true)
        self.allowed = allowed or {}
        return (self)
    end
})