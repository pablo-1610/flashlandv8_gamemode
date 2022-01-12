--[[
  This file is part of FlashLand.
  Created at 12/01/2022 16:59
  
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
    if ((_FlashClient_PlayerMenu.var.selectedOrganisation ~= nil) and (_FlashClient_PlayerMenu.var.selectedGradeOrganisation ~= nil)) then
        local organisations = _FlashClient_Staff.getOrganisationList()
        local organisationData = organisations[_FlashClient_PlayerMenu.var.selectedOrganisation]
        local gradeData = organisationData.grades[_FlashClient_PlayerMenu.var.selectedGradeOrganisation]
        RageUI.Separator(("Organisation : ~b~%s"):format(organisationData.jobLabel))
        RageUI.Separator(("Grade ID : ~r~%s"):format(gradeData.gradeId))
        RageUI.Separator(("Grade : ~o~%s"):format(gradeData.gradeLabel))
        RageUI.Line()
        if (_FlashLand.countTable(gradeData.permissions) <= 0) then
            RageUI.Separator("~r~Aucune ~s~permission à ce rôle !")
        else
            RageUI.Separator("↓↓ Grade(s) du rôle ↓↓")
            for _, permission in pairs(gradeData.permissions) do
                RageUI.Button(("Perm : ~b~%s"):format(permission), nil, {}, true, {})
            end
        end
    end
end