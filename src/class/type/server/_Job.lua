--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:34
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Job
---@field public id number
---@field public label string
---@field public grades table<_JobGrade>
_Job = {}
_Job.__index = _Job

setmetatable(_Job, {
    __call = function(_, id, label, grades)
        local self = setmetatable({}, _Job)
        self.id = id
        self.label = label
        self.grades = grades

        self.connectedEmployees = {}
        self.inventory = {} -- TODO → _Inventory
        self.metadata = {}

        self.restrictedZones = {}
        self.restrictedBlips = {}

        self.vehicles = {}
        self.localData = {}

        return self
    end
})

---getVehicles
---@return table<table>
function _Job:getVehicles()
    return self.vehicles
end

---subscribeToRestrictedThings
---@param _src number
---@return void
function _Job:subscribeToRestrictedThings(_src)
    ---@param zone _Zone
    for _, zone in pairs(self.restrictedZones) do
        zone:addAllow(_src)
    end
    ---@param blip _Blip
    for _, blip in pairs(self.restrictedBlips) do
        blip:addAllow(_src)
    end
end

---unsubscribeFromRestrictedThings
---@param _src number
---@return void
function _Job:unsubscribeFromRestrictedThings(_src)
    ---@param zone _Zone
    for _, zone in pairs(self.restrictedZones) do
        zone:removeAllowed(_src)
    end
    ---@param blip _Blip
    for _, blip in pairs(self.restrictedBlips) do
        blip:removeAllowed(_src)
    end
end

---hasRestrictedThings
---@return boolean
function _Job:hasRestrictedThings()
    return #self.restrictedZones > 0 or #self.restrictedBlips > 0
end

---isEmployee
---@param _src number
---@return boolean
function _Job:isEmployee(_src)
    return self.connectedEmployees[_src] ~= nil
end

---playerJoinedJob
---@param _src number
---@return void
function _Job:playerJoinedJob(_src)
    if (not (self:isEmployee(_src))) then
        table.insert(self.connectedEmployees, _src)
        if (self:hasRestrictedThings()) then
            self:subscribeToRestrictedThings(_src)
        end
    end
end

---playerLeftJob
---@param _src number
---@return void
function _Job:playerLeftJob(_src)
    if (self:isEmployee(_src)) then
        table.remove(self.connectedEmployees, _src)
        if (self:hasRestrictedThings()) then
            self:unsubscribeFromRestrictedThings(_src)
        end
    end
end

---setMetadata
---@param key string
---@param value any
function _Job:setMetadata(key, value)
    self.metadata[key] = value
    return self
end

---metadataExists
---@param key string
---@return boolean
function _Job:metadataExists(key)
    return self.metadata[key] ~= nil
end

---getMetadata
---@param key string
---@return any
function _Job:getMetadata(key)
    return self.metadata[key]
end

---initializeLocalData
---@return void
function _Job:setupLocalData(localDataName, defaultData)
    localDataName = localDataName:lower()
    local id = self.id
    if (not (_FlashServer_Utils.file_exists(("resources/flashland/src/jobs/%s/%s.json"):format(id, localDataName)))) then
        local data = defaultData or {}
        CreateThread(function()
            _FlashServer_Utils.file_write(("resources/flashland/src/jobs/%s/%s.json"):format(id, localDataName), json.encode(data))
        end)
        self.localData[localDataName] = data
    else
        local data = _FlashServer_Utils.file_read(("resources/flashland/src/jobs/%s/%s.json"):format(id, localDataName))
        self.localData[localDataName] = json.decode(data)
    end
end

---saveLocalData
---@return void
function _Job:saveLocalData(localDataName)
    localDataName = localDataName:lower()
    local id = self.id
    local data = self.localData[localDataName]
    CreateThread(function()
        _FlashServer_Utils.file_write(("resources/flashland/src/jobs/%s/%s.json"):format(id, localDataName), json.encode(data))
    end)
end

---saveAllLocalData
---@return void
function _Job:saveAllLocalData()
    for localDataName, _ in pairs(self.localData) do
        self:saveLocalData(localDataName)
    end
end

---setLocalData
---@param localDataName string
---@param value any
---@return void
function _Job:setLocalData(localDataName, value)
    localDataName = localDataName:lower()
    self.localData[localDataName] = value
    self:saveLocalData(localDataName)
end

---getLocalData
---@param localDataName string
---@return any
function _Job:getLocalData(localDataName)
    localDataName = localDataName:lower()
    return self.localData[localDataName]
end

---getLastGrade
---@return _JobGrade
function _Job:getLastGrade()
    return self.grades[#self.grades]
end

---getGrade
---@param id number
---@return _JobGrade
function _Job:getGrade(id)
    for _, grade in ipairs(self.grades) do
        if grade.id == id then
            return grade
        end
    end
end

---gradeExists
---@param id string
---@return boolean
function _Job:gradeExists(id)
    for _, grade in ipairs(self.grades) do
        if grade.id == id then
            return true
        end
    end
    return false
end

---addRestrictedZone
---@param zone _Zone
---@return _Job
function _Job:addRestrictedZone(zone)
    table.insert(self.restrictedZones, zone)
    return self
end

---addRestrictedBlip
---@param blip _Blip
---@return _Job
function _Job:addRestrictedBlip(blip)
    table.insert(self.restrictedBlips, blip)
    return self
end