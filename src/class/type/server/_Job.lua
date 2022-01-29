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

        self.inventory = {} -- TODO → _Inventory
        self.metadata = {}

        return self
    end
})