--[[
  This file is part of FlashLand.
  Created at 11/01/2022 17:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _Orga
---@field public jobName string
---@field public jobLabel string
---@field public grade table
---@field public bossPos table
---@field public safePos table
---@field public spawnVehiclePos table
---@field public delVehiclePos table
---@field public blip table
---@field public allowed table
---@field public players table
---@field public inventory table
---@field public weapons table
_Orga = {}
_Orga.__index = _Orga

setmetatable(_Orga, {
    __call = function(_, jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blip, allowed)
        local self = setmetatable({}, _Orga)
        self.jobName = jobName
        self.jobLabel = jobLabel
        self.grade = {}
        self.bossPos = _FlashServer_Zones.createPublic(vector3(bossPos.x, bossPos.y, bossPos.z), { 255, 255, 255 }, function(source, player, zone)
            _FlashServer_Organisation.openBossAction(source, player, zone.id, self.jobName)
        end, "Appuyez sur ~INPUT_CONTEXT~ pour gérer votre organisation", 20.0, 1.0, true, 180.0)
        self.safePos = _FlashServer_Zones.createPublic(vector3(safePos.x, safePos.y, safePos.z), { 255, 255, 255 }, function(source, player, zone)
            _FlashServer_Organisation.openSafe(source, player, zone.id, self.jobName)
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre", 20.0, 1.0, true, 180.0)
        self.spawnVehiclePos = _FlashServer_Zones.createPublic(vector3(spawnVehiclePos.x, spawnVehiclePos.y, spawnVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            _FlashServer_Organisation.openSpawnVehicleMenu(source, player, zone.id, self.jobName)
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage", 20.0, 1.0, true, 180.0)
        self.delVehiclePos = _FlashServer_Zones.createPublic(vector3(delVehiclePos.x, delVehiclePos.y, delVehiclePos.z), { 255, 255, 255 }, function(source, player, zone)
            _FlashServer_Organisation.rangeVehicle(source, player, zone.id, self.jobName)
        end, "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule", 20.0, 1.0, true, 180.0)
        self.blip = _FlashServer_Blips.createPublic(vector3(blip.pos.x, blip.pos.y, blip.pos.z), blip.id, blip.color, _Config.genericBlipSize, blip.name, true)
        self.allowed = allowed or {}
        self.players = {}
        self.inventory = {}
        self.weapons = {}
        return (self)
    end
})

function _Orga:loadOrganisationInventory()
    _FlashServer_Database.query("SELECT * FROM flash_organisation_inventory WHERE orga = @orga", {
        ["orga"] = self.jobName
    }, function(result)
        if (result[1].inventory) then
            for name, value in pairs(json.decode(result[1].inventory)) do
                if (not (_FlashServer_Items.exists(name))) then
                    return
                end
                self.inventory[name] = value
            end
        else
            self:createSafeInventory()
        end
    end)
end

function _Orga:createSafeInventory()
    _FlashServer_Database.insert("INSERT INTO flash_organisation_inventory (orga) VALUES (@orga)", {
        ["orga"] = self.jobName
    })
end

function _Orga:itemExist(name)
    for item, _ in pairs(self.inventory) do
        if (item == name) then
            return (true)
        end
    end
    return (false)
end

function _Orga:addItem(name, value)
    if (not (_FlashServer_Items.exists(name))) then
        return
    end
    if (self:itemExist(name)) then
        self.inventory[name] = (self.inventory[name] + value)
    else
        self.inventory[name] = value
    end
end

function _Orga:removeItem(name, value)
    if (not (_FlashServer_Items.exists(name))) then
        return
    end
    if (self:itemExist(name)) then
        local newAmount = (self.inventory[name] - value)
        if (newAmount <= 0) then
            self.inventory[name] = nil
        else
            self.inventory[name] = (self.inventory[name] - value)
        end
    end
end

function _Orga:saveSafeInventory()
    _FlashServer_Database.execute("UPDATE flash_organisation_inventory SET inventory = @inventory WHERE orga = @orga", {
        ["inventory"] = json.encode(self.inventory),
        ["orga"] = self.jobName
    })
end

function _Orga:loadOrganisationLoadout()
    _FlashServer_Database.query("SELECT * FROM flash_organisation_loadout WHERE orga = @orga", {
        ["orga"] = self.jobName
    }, function(result)
        if (result[1].loadout) then
            for name, value in pairs(json.decode(result[1].loadout)) do
                self.weapons[name] = value
            end
        else
            self:createSafeLoadout()
        end
    end)
end

function _Orga:createSafeLoadout()
    _FlashServer_Database.insert("INSERT INTO flash_organisation_loadout (orga) VALUES (@orga)", {
        ["orga"] = self.jobName
    })
end

function _Orga:weaponExist(name)
    for weapon, _ in pairs(self.weapons) do
        if (weapon == name) then
            return (true)
        end
    end
    return (false)
end

function _Orga:addWeapon(name)
    if (not (_Static_Weapons[GetHashKey(name:lower())])) then
        return
    end
    if (self:weaponExist(name)) then
        self.weapons[name] = (self.weapons[name] + 1)
    else
        self.weapons[name] = 1
    end
end

function _Orga:removeWeapon(name)
    if (not (_Static_Weapons[GetHashKey(name:lower())])) then
        return
    end
    if (self:weaponExist(name)) then
        local newAmount = (self.weapons[name] - 1)
        if (newAmount <= 0) then
            self.weapons[name] = nil
        else
            self.weapons[name] = (self.weapons[name] - 1)
        end
    end
end

function _Orga:saveSafeLoadout()
    _FlashServer_Database.execute("UPDATE flash_organisation_loadout SET loadout = @loadout WHERE orga = @orga", {
        ["loadout"] = json.encode(self.weapons),
        ["orga"] = self.jobName
    })
end

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
            _FlashServer_Organisation.openBossAction(source, player, zone.id, self.jobName)
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
            _FlashServer_Organisation.openSafe(source, player, zone.id, self.jobName)
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
            _FlashServer_Organisation.openSpawnVehicleMenu(source, player, zone.id, self.jobName)
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
            _FlashServer_Organisation.rangeVehicle(source, player, zone.id, self.jobName)
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

function _Orga:getMember(flashId)
    for _, data in pairs(self.players) do
        if (flashId == data.flashId) then
            return (true)
        end
    end
    return (false)
end

function _Orga:addNewMember(data)
    if (not (self:getMember(data.flashId))) then
        table.insert(self.players, data)
    end
end

function _Orga:removeMember(flashId)
    if (self:getMember(flashId)) then
        for index, data in pairs(self.players) do
            if (flashId == data.flashId) then
                table.remove(self.players, index)
            end
        end
    end
end

function _Orga:updatePlayerGrade(flashId, newGrade)
    if (self:getMember(flashId)) then
        for _, player in pairs(self.players) do
            if (player.flashId == flashId) then
                player.grade = newGrade
            end
        end
    end
end