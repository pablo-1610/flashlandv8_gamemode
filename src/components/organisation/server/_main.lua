--[[
  This file is part of FlashLand.
  Created at 11/01/2022 18:20
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Organisation
_FlashServer_Organisation = {}

local list = {}

_FlashServer_Organisation.exist = function(jobName)
    return (list[jobName] ~= nil)
end

_FlashServer_Organisation.gradeExist = function(jobName, id)
    return (list[jobName].grade[id] ~= nil)
end

_FlashServer_Organisation.getAll = function()
    return (list)
end

_FlashServer_Organisation.get = function(jobName)
    if (not (_FlashServer_Organisation.exist(jobName))) then
        return
    end
    return (list[jobName])
end

_FlashServer_Organisation.getGrade = function(jobName, id)
    if (not (_FlashServer_Organisation.gradeExist(jobName, id))) then
        return
    end
    return (list[jobName].grade[id])
end

_FlashServer_Organisation.getAllGrades = function(jobName)
    if (not (_FlashServer_Organisation.exist(jobName))) then
        return
    end
    return (list[jobName].grade)
end

_FlashServer_Organisation.add = function(orga)
    _FlashLand.log(("^1Ajout ^7d'une ^6ORGANISATION ^7name: ^3%s"):format(orga.jobName))
    list[orga.jobName] = orga
end

_FlashServer_Organisation.remove = function(jobName)
    _FlashLand.log(("^1Suppression ^7d'une ^6ORGANISATION ^7name: ^3%s"):format(jobName))
    list[jobName] = nil
end

_FlashServer_Organisation.addOrgaGrade = function(jobName, grade)
    list[jobName].grade[grade.gradeId] = grade
end

_FlashServer_Organisation.removeOrgaGrade = function(jobName, id)
    list[jobName].grade[id] = nil
end

_FlashServer_Organisation.loadGrade = function()
    _FlashServer_Database.query("SELECT flash_orga_grades.orgaId,flash_orga_grades.grade_name,flash_orga_grades.grade_label,flash_orga_grades.grade_id,flash_orga_grades_permissions.permission FROM flash_orga_grades LEFT JOIN flash_orga_grades_permissions ON flash_orga_grades.orgaId = flash_orga_grades_permissions.orga_name WHERE flash_orga_grades.grade_id = flash_orga_grades_permissions.gradeId", {}, function(result)
        for row, data in pairs(result) do
            if (_FlashServer_Organisation.gradeExist(data.orgaId, data.grade_id)) then
                ---@type _OrgaGrade
                local orgaGrade = _FlashServer_Organisation.getGrade(data.orgaId, data.grade_id)
                orgaGrade:addPermission(data.permission)
            else
                ---@type _OrgaGrade
                local orgaGrade = _OrgaGrade(data.orgaId, data.grade_name, data.grade_label, data.grade_id)
                _FlashServer_Organisation.addOrgaGrade(data.orgaId, orgaGrade)
                orgaGrade:addPermission(data.permission)
            end
        end
    end)
end

_FlashLand.loadedComponent("organisation")