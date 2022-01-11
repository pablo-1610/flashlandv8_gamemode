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
    __call = function(_, id, job, grade, bossPos, safePos, spawnVehiclePos, delVehiclePos, blipPos, blipName, blipId, blipColor, allowed)
        local self = setmetatable({}, _Orga)
        self.id = id
        self.job = job
        self.grade = grade
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
        self.blip = _FlashServer_Blips.createPublic(vector3(blipPos.x, blipPos.y, blipPos.z), blipId, blipColor, _Config.genericBlipSize, blipName, true)
        self.allowed = allowed or {}
        return (self)
    end
})

RegisterCommand("encode", function()
    print(json.encode(vector3(0.0, 0.0, 0.0)), json.encode({ pos = vector3(0.0, 0.0, 0.0), name = "vagos", id = 56, color = 28 }))
end)