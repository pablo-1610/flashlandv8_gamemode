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

function _OrgaGrade:hasSinglePermission(query)
    for _, permission in pairs(self.permissions) do
        if (permission == query) then
            return true
        end
    end
    return false
end

function _OrgaGrade:hasPermission(query)
    -- TODO → Do group splitter, eg: "admin.*" will allows everything in admin
    return (self:hasSinglePermission(query))
end

function _OrgaGrade:newPermission(permission)
    _FlashServer_Database.insert("INSERT INTO flash_orga_grades_permissions (orga_name, gradeId, permission) VALUES (@orga_name, @gradeId, @permission)", {
        ["orga_name"] = self.jobName,
        ["gradeId"] = self.gradeId,
        ["permission"] = permission
    })
    self:addPermission(permission)
end

function _OrgaGrade:addPermission(permission)
    table.insert(self.permissions, permission)
end

function _OrgaGrade:addPermissions(permissions)
    for _, permission in pairs(permissions) do
        self:addPermissions(permission)
    end
end

function _OrgaGrade:deletePermission(query)
    if (not (self:hasPermission(query))) then
        _FlashLand.log(("Permission introuable dans %s: %s"):format(self.label, query))
        return
    end
    _FlashServer_Database.execute("DELETE permission = @permission FROM flash_orga_grades_permissions WHERE orga_name = @orga_name AND gradeId = @gradeId", {
        ["permission"] = query,
        ["orga_name"] = self.jobName,
        ["gradeId"] = self.gradeId
    })
    for index, permission in pairs(self.permissions) do
        if (permission == query) then
            table.remove(self.permissions, index)
            break
        end
    end
end