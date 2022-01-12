--[[
  This file is part of FlashLand.
  Created at 12/01/2022 16:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[23] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedOrganisation ~= nil) then
        local organisations = _FlashClient_Staff.getOrganisationList()
        local organisationData = organisations[_FlashClient_PlayerMenu.var.selectedOrganisation]
        RageUI.Separator(("Organisation : ~b~%s"):format(organisationData.jobLabel))
        RageUI.Separator(("Total de grade(s) : ~r~%s"):format(#organisationData.grades))
        RageUI.Line()
        perm = "admin.openOrgaGrade"
        for gradeId, grade in pairs(organisationData.grades) do
            RageUI.Button(("%s [~o~%s~s~] - %s"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), grade.gradeId, grade.gradeLabel), nil, {}, (checkPerm(perm)), {
                onSelected = function()
                    _FlashClient_PlayerMenu.var.selectedGradeOrganisation = gradeId
                end
            }, _FlashClient_PlayerMenu.getMenus()[24])
        end
    end
end