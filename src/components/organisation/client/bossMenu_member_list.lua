--[[
  This file is part of FlashLand.
  Created at 22/02/2022 17:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[5] = function(player)
    RageUI.Separator(("Total : ~r~%s"):format(#_FlashClient_Organisation_Boss.intraVars.members))
    RageUI.Line()
    for flashId, data in pairs(_FlashClient_Organisation_Boss.intraVars.members) do
        RageUI.Button(("%s"):format(data.name), nil, { RightLabel = ("%s ~r~→→"):format(data.grade.gradeLabel) }, ((player.flashId ~= data.flashId) and checkPerm("orga.bossManageMember")), {
            onSelected = function()
                _FlashClient_Organisation_Boss.intraVars.memberSelected = data.flashId
            end,
        }, _FlashClient_Organisation_Boss.getMenus()[6])
    end
end