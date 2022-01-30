--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:39
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _JobGrade
---@field public id string
---@field public label string
---@field public salary number
---@field public permissions table
_JobGrade = {}
_JobGrade.__index = _JobGrade

setmetatable(_JobGrade, {
    __call = function(_, id, label, salary, permissions)
        local self = setmetatable({}, _JobGrade)
        self.id = id
        self.label = label
        self.salary = salary
        self.permissions = permissions

        return self
    end
})