--[[
  This file is part of FlashLand.
  Created at 23/02/2022 19:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local organisation = {}
local gradeIndex = 1

---@param player _Player
_FlashClient_PlayerMenu.drawer[30] = function(player)
    if (_FlashClient_PlayerMenu.var.selectedPlayer ~= nil) then
        local playerId = _FlashClient_PlayerMenu.var.selectedPlayer
        ---@type _LightPlayer
        local playerData = _FlashClient_Staff.getPlayerList()[playerId]
        RageUI.Separator(("Nom : ~r~%s"):format(playerData.name))
        RageUI.Separator(("FlashID : ~r~%s"):format(playerData.flashId))
        RageUI.Separator(("Id : ~r~%s"):format(playerData.sId))
        RageUI.Separator(("Orga : ~r~%s"):format(playerData.orga.orga))
        RageUI.Separator(("Grade : ~r~%s"):format(playerData.orga.grade.label))
        RageUI.Line()
        ---@param data _LightOrga
        for id, data in pairs(_FlashClient_Staff.getOrganisationList()) do
            RageUI.Separator(("%s"):format(data.jobLabel))
            ---@param grade _OrgaGrade
            for _, grade in pairs(_FlashClient_Staff.getOrganisationList()[id].grades) do
                RageUI.Button(("[~r~%s~s~] ~o~%s"):format(grade.gradeId, grade.gradeLabel), nil, { RightLabel = "~r~→→" }, true, {
                    onSelected = function()
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:changePlayerOrganisation", playerId, data.jobName, grade.gradeId)
                    end,
                })
            end
        end
    end
end