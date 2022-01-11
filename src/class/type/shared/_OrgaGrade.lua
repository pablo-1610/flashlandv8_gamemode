--[[
  This file is part of FlashLand.
  Created at 11/01/2022 19:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---@class _OrgaGrade
_OrgaGrade = {}
_OrgaGrade.__index = _OrgaGrade

setmetatable(_OrgaGrade, {
    __call = function(_, jobName, gradeName, gradeLabel, gradeId, permissions)
        local self = setmetatable({}, _OrgaGrade)
        self.jobName = jobName
        self.gradeName = gradeName
        self.gradeLabel = gradeLabel
        self.gradeId = gradeId
        self.permissions = permissions or {}
        return (self)
    end
})

function _OrgaGrade:addPermission(permission)
    table.insert(self.permissions, permission)
end