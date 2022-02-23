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
local permissions = {}

for _, permission in pairs(_Config.OrganisationPermission) do
    table.insert(permissions, permission)
end

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

_FlashServer_Organisation.permissionExist = function(name)
    for _, v in pairs(permissions) do
        if (v.perm == name) then
            return (true)
        end
    end
    return (false)
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
    _FlashServer_Database.query("SELECT * FROM flash_orga_grades", {}, function(result)
        for row, data in pairs(result) do
            if (not (_FlashServer_Organisation.gradeExist(data.orgaId, data.grade_id))) then
                ---@type _OrgaGrade
                local orgaGrade = _OrgaGrade(data.orgaId, data.grade_name, data.grade_label, data.grade_id)
                _FlashServer_Organisation.addOrgaGrade(data.orgaId, orgaGrade)
                _FlashServer_Database.query("SELECT * FROM flash_orga_grades_permissions WHERE orga_name = @orga_name AND gradeId = @gradeId", {
                    ["orga_name"] = data.orgaId,
                    ["gradeId"] = data.grade_id
                }, function(permission)
                    for _, permData in pairs(permission) do
                        ---@type _OrgaGrade
                        local orga = _FlashServer_Organisation.getGrade(permData.orga_name, permData.gradeId)
                        orga:addPermission(permData.permission)
                    end
                end)
            end
        end
    end)
end

_FlashServer_Organisation.loadPlayers = function()
    _FlashServer_Database.query("SELECT * FROM flash_players_organisation LEFT JOIN flash_players ON flash_players.flashId = flash_players_organisation.flashId", {}, function(result)
        for row, data in pairs(result) do
            if (_FlashServer_Organisation.exist(data.orga)) then
                if (_FlashServer_Organisation.gradeExist(data.orga, data.orga_grade)) then
                    ---@type _Orga
                    local orga = _FlashServer_Organisation.get(data.orga)
                    local identity = json.decode(data.identity)
                    local playerData = {}
                    playerData[data.flashId] = { name = ("%s %s"):format(identity.firstname, identity.lastname), flashId = data.flashId, grade = _FlashServer_Organisation.getGrade(data.orga, data.orga_grade) }
                    orga:addNewMember(playerData[data.flashId])
                end
            end
        end
    end)
end

_FlashLand.loadedComponent("organisation")