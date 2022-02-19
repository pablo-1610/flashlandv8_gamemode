--[[
  This file is part of FlashLand.
  Created at 19/02/2022 12:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

local function checkGradePerm(perm, permissions)
    for _, permission in pairs(permissions) do
        if (perm == permission) then
            return (true)
        end
    end
    return (false)
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[3] = function(player)
    local perm = nil
    if (_FlashClient_Organisation_Boss.intraVars.gradesSelected ~= nil) then
        local gradeId = _FlashClient_Organisation_Boss.intraVars.gradesSelected
        ---@type _OrgaGrade
        local grade = _FlashClient_Organisation_Boss.intraVars.grades[gradeId]
        RageUI.Separator(("Grade : ~r~%s"):format(grade.gradeLabel))
        RageUI.Separator(("Id : ~r~%s"):format(grade.gradeId))
        RageUI.Line()
        RageUI.Button("Supprimer le grade", nil, {}, (checkPerm("orga.deleteGrade")), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("orga:deleteGrade", _FlashClient_Organisation_Boss.intraVars.name, grade.gradeId)
            end,
        })
        RageUI.Line()
        RageUI.Separator("~y~↓↓ ~r~Permissions ~y~↓↓")
        for _, permission in pairs(_Config.OrganisationPermission) do
            RageUI.Checkbox(("Perm : %s"):format(permission.label), ("~y~Description : ~s~%s"):format(permission.description), (checkGradePerm(permission.perm, grade.permissions)), {}, {
                onChecked = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("orga:addPermissionForOrganisationGrade", _FlashClient_Organisation_Boss.intraVars.name, gradeId, permission.perm)
                end,
                onUnChecked = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("orga:removePermissionForOrganisationGrade", _FlashClient_Organisation_Boss.intraVars.name, gradeId, permission.perm)
                end
            })
        end
    end
end