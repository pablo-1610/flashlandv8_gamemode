--[[
  This file is part of FlashLand.
  Created at 19/02/2022 12:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[2] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Boss.intraVars.label))
    RageUI.Separator(("Grade(s) : ~r~%s"):format(#_FlashClient_Organisation_Boss.intraVars.grades))
    RageUI.Line()
    RageUI.Button("Créer un grade", nil, { RightLabel = "~r~→→" }, (checkPerm("orga.createGrade")), {}, _FlashClient_Organisation_Boss.getMenus()[4])
    RageUI.Line()
    RageUI.Separator("~y~↓↓ ~r~Grade(s) ~y~↓↓")
    if (_FlashClient_Organisation_Boss.intraVars.grades ~= nil) then
        ---@param data _OrgaGrade
        for _, data in pairs(_FlashClient_Organisation_Boss.intraVars.grades) do
            if (data.gradeName == "boss") then
                RageUI.Button(("[~o~%s~s~] - ~b~%s"):format(data.gradeId, data.gradeLabel), nil, { RightLabel = "~r~→→" }, false, {
                    onSelected = function()
                        _FlashClient_Organisation_Boss.intraVars.gradesSelected = data.gradeId
                    end
                }, _FlashClient_Organisation_Boss.getMenus()[3])
            else
                RageUI.Button(("[~o~%s~s~] - ~b~%s"):format(data.gradeId, data.gradeLabel), nil, { RightLabel = "~r~→→" }, (checkPerm("orga.bossManageOrganisationGrade")), {
                    onSelected = function()
                        _FlashClient_Organisation_Boss.intraVars.gradesSelected = data.gradeId
                    end
                }, _FlashClient_Organisation_Boss.getMenus()[3])
            end
        end
    end
end