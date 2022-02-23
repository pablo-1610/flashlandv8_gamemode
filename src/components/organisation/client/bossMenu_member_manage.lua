--[[
  This file is part of FlashLand.
  Created at 22/02/2022 19:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local gardeList = {}
local gradeListIndex = 1

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[6] = function(player)
    if (_FlashClient_Organisation_Boss.intraVars.memberSelected ~= nil) then
        local flashId = _FlashClient_Organisation_Boss.intraVars.memberSelected
        for i, playerData in pairs(_FlashClient_Organisation_Boss.intraVars.members) do
            if (playerData.flashId == flashId) then
                RageUI.Separator(("Nom : ~r~%s"):format(playerData.name))
                RageUI.Separator(("Grade : ~r~%s"):format(playerData.grade.gradeLabel))
                RageUI.Line()
                RageUI.Button("~r~Virer", nil, { RightLabel = "~r~→→" }, (checkPerm("orga.bossManageMember")), {
                    onSelected = function()
                        RageUI.GoBack()
                        _FlashClient_Organisation_Boss.intraVars.memberSelected = nil
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("orga:removePlayer", _FlashClient_Organisation_Boss.intraVars.name, playerData.flashId)
                    end,
                })
                RageUI.Line()
                RageUI.Separator("~y~↓↓ ~r~Grades ~y~↓↓")
                ---@param grade _OrgaGrade
                for _, grade in pairs(_FlashClient_Organisation_Boss.intraVars.grades) do
                    RageUI.Button(("Changer pour : ~b~%s"):format(grade.gradeLabel), nil, { RightLabel = "~r~→→" }, ((grade.gradeName ~= playerData.grade.gradeName) and checkPerm("orga.bossManageMember")), {
                        onSelected = function()
                            _FlashLand.setIsWaitingForServer(true)
                            _FlashLand.toServer("orga:updatePlayerGrade", _FlashClient_Organisation_Boss.intraVars.name, playerData.flashId, grade.gradeId)
                        end,
                    })
                end
            end
        end
    end
end