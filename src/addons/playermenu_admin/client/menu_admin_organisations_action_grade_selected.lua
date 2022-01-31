--[[
  This file is part of FlashLand.
  Created at 12/01/2022 16:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local permissionsList = {}

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

for _, permission in pairs(_Config.OrganisationPermission) do
    table.insert(permissionsList, permission)
end

local function getPlayerHasPermission(actualPermissionRank, permissionSelected)
    for _, rankPermission in pairs(actualPermissionRank) do
        if (permissionSelected == rankPermission) then
            return (true)
        end
    end
    return (false)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[24] = function(player)
    local perm = nil
    if ((_FlashClient_PlayerMenu.var.selectedOrganisation ~= nil) and (_FlashClient_PlayerMenu.var.selectedGradeOrganisation ~= nil)) then
        local organisations = _FlashClient_Staff.getOrganisationList()
        local organisationData = organisations[_FlashClient_PlayerMenu.var.selectedOrganisation]
        local gradeData = organisationData.grades[_FlashClient_PlayerMenu.var.selectedGradeOrganisation]
        RageUI.Separator(("Organisation : ~b~%s"):format(organisationData.jobLabel))
        RageUI.Separator(("Grade ID : ~r~%s"):format(gradeData.gradeId))
        RageUI.Separator(("Grade : ~o~%s"):format(gradeData.gradeLabel))
        RageUI.Line()
        RageUI.Separator("↓↓ Grade(s) ↓↓")
        perm = "admin.managePermissionOrganisationGrade"
        for _, permData in pairs(permissionsList) do
            if (checkPerm(perm)) then
                RageUI.Checkbox(("Perm : %s"):format(permData.label), ("~y~Information : ~s~%s"):format(permData.description), (getPlayerHasPermission(gradeData.permissions, permData.perm)), {}, {
                    onChecked = function()
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:addPermissionForOrganisationGrade", organisationData.jobName, gradeData.gradeId, permData.perm)
                    end,
                    onUnChecked = function()
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:removePermissionForOrganisationGrade", organisationData.jobName, gradeData.gradeId, permData.perm)
                    end
                })
            else
                RageUI.Button(("Perm : %s"):format(permData.label), ("~r~Tu n'as pas la permission pour gérer les grades !\n~y~Information : ~s~%s"):format(permData.description), {}, false, {})
            end
        end
    end
end