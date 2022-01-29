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
        self.employees = employees
        self.grades = grades

        self.connectedEmployees = {}
        self.inventory = {} -- TODO → _Inventory
        self.metadata = {}

        return self
    end
})

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