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
        self.bossPos = _FlashServer_Zones.createPublic(vector3(bossPos.x, bossPos.y, bossPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour gérer votre organisation", 20.0, 1.0, true, 180.0)
        self.safePos = _FlashServer_Zones.createPublic(vector3(safePos.x, safePos.y, safePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre", 20.0, 1.0, true, 180.0)
        self.spawnVehiclePos = _FlashServer_Zones.createPublic(vector3(spawnVehiclePos.x, spawnVehiclePos.y, spawnVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 20.0, 1.0, true, 180.0)
        self.delVehiclePos = _FlashServer_Zones.createPublic(vector3(delVehiclePos.x, delVehiclePos.y, delVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule", 20.0, 1.0, true, 180.0)
        self.blip = _FlashServer_Blips.createPublic(vector3(blip.pos.x, blip.pos.y, blip.pos.z), blip.id, blip.color, _Config.genericBlipSize, blip.name, true)
        self.allowed = allowed or {}
        return (self)
    end
})

function _Orga:updateOrgaBossAction(newPos)
    for _, _src in pairs(self.bossPos.subscribed) do
        if (self.bossPos:isSubscribed(_src)) then
            self.bossPos:unsubscribe(_src, false)
        end
    end
    local zoneId = self.bossPos.id
    _FlashServer_Zones.remove(zoneId)
    _FlashServer_Database.execute("UPDATE flash_orga SET boss = (@boss) WHERE name = @name", {
        ["boss"] = json.encode(newPos),
        ["name"] = self.jobName
    }, function()
        self.bossPos = _FlashServer_Zones.createPublic(vector3(newPos.x, newPos.y, newPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour gérer votre organisation", 20.0, 1.0, true, 180.0)
    end)
end

function _Orga:updateCoffreAction(newPos)
    for _, _src in pairs(self.safePos.subscribed) do
        if (self.safePos:isSubscribed(_src)) then
            self.safePos:unsubscribe(_src, false)
        end
    end
    local zoneId = self.safePos.id
    _FlashServer_Zones.remove(zoneId)
    _FlashServer_Database.execute("UPDATE flash_orga SET safe = (@safe) WHERE name = @name", {
        ["safe"] = json.encode(newPos),
        ["name"] = self.jobName
    }, function()
        self.safePos = _FlashServer_Zones.createPublic(vector3(newPos.x, newPos.y, newPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre", 20.0, 1.0, true, 180.0)
    end)
end

function _Orga:updateSpawnVehicleAction(newPos)
    for _, _src in pairs(self.spawnVehiclePos.subscribed) do
        if (self.spawnVehiclePos:isSubscribed(_src)) then
            self.spawnVehiclePos:unsubscribe(_src, false)
        end
    end
    local zoneId = self.spawnVehiclePos.id
    _FlashServer_Zones.remove(zoneId)
    _FlashServer_Database.execute("UPDATE flash_orga SET spawn_vehicle = (@spawn_vehicle) WHERE name = @name", {
        ["spawn_vehicle"] = json.encode(newPos),
        ["name"] = self.jobName
    }, function()
        self.spawnVehiclePos = _FlashServer_Zones.createPublic(vector3(newPos.x, newPos.y, newPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 20.0, 1.0, true, 180.0)
    end)
end

function _Orga:updateDeleteVehicleAction(newPos)
    for _, _src in pairs(self.delVehiclePos.subscribed) do
        if (self.delVehiclePos:isSubscribed(_src)) then
            self.delVehiclePos:unsubscribe(_src, false)
        end
    end
    local zoneId = self.delVehiclePos.id
    _FlashServer_Zones.remove(zoneId)
    _FlashServer_Database.execute("UPDATE flash_orga SET del_vehicle = (@del_vehicle) WHERE name = @name", {
        ["del_vehicle"] = json.encode(newPos),
        ["name"] = self.jobName
    }, function()
        self.delVehiclePos = _FlashServer_Zones.createPublic(vector3(newPos.x, newPos.y, newPos.z), { 255, 255, 255 }, function(source, player, zone)
            -- TODO -> function open boss menu
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule", 20.0, 1.0, true, 180.0)
    end)
end

function _Orga:updateBlip(newPos)
    for _, _src in pairs(self.blip.subscribed) do
        if (self.blip:isSubscribed(_src)) then
            self.blip:unsubscribe(_src, false)
        end
    end
    local zoneId = self.blip.id
    _FlashServer_Blips.remove(zoneId)
    local updateBlip = { name = self.blip.label, color = self.blip.color, pos = newPos, id = self.blip.sprite }
    _FlashServer_Database.execute("UPDATE flash_orga SET blip = (@blip) WHERE name = @name", {
        ["blip"] = json.encode(updateBlip),
        ["name"] = self.jobName
    }, function()
        self.blip = _FlashServer_Blips.createPublic(vector3(updateBlip.pos.x, updateBlip.pos.y, updateBlip.pos.z), updateBlip.id, updateBlip.color, _Config.genericBlipSize, updateBlip.name, true)
    end)
end

function _Orga:deleteAllInteractions()
    for _, _src in pairs(self.bossPos.subscribed) do
        if (self.bossPos:isSubscribed(_src)) then
            self.bossPos:unsubscribe(_src, false)
        end
    end
    local bossZoneId = self.bossPos.id
    _FlashServer_Zones.remove(bossZoneId)
    for _, _src in pairs(self.safePos.subscribed) do
        if (self.safePos:isSubscribed(_src)) then
            self.safePos:unsubscribe(_src, false)
        end
    end
    local safeZoneId = self.safePos.id
    _FlashServer_Zones.remove(safeZoneId)
    for _, _src in pairs(self.spawnVehiclePos.subscribed) do
        if (self.spawnVehiclePos:isSubscribed(_src)) then
            self.spawnVehiclePos:unsubscribe(_src, false)
        end
    end
    local spawnVehicleZoneId = self.spawnVehiclePos.id
    _FlashServer_Zones.remove(spawnVehicleZoneId)
    for _, _src in pairs(self.delVehiclePos.subscribed) do
        if (self.delVehiclePos:isSubscribed(_src)) then
            self.delVehiclePos:unsubscribe(_src, false)
        end
    end
    local deleteVehicleZoneId = self.delVehiclePos.id
    _FlashServer_Zones.remove(deleteVehicleZoneId)
    for _, _src in pairs(self.blip.subscribed) do
        if (self.blip:isSubscribed(_src)) then
            self.blip:unsubscribe(_src, false)
        end
    end
    local blipId = self.blip.id
    _FlashServer_Blips.remove(blipId)
end