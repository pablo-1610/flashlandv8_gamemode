--[[
  This file is part of FlashLand.
  Created at 06/02/2022 12:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[1] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Boss.intraVars.label))
    RageUI.Line()
    RageUI.Button("Grades", nil, { RightLabel = "~r~→→" }, (checkPerm("orga.openBossMenu")), {}, _FlashClient_Organisation_Boss.getMenus()[2])
    RageUI.Button("Membre", nil, { RightLabel = "~r~→→" }, (checkPerm("orga.bossMember")), {}, _FlashClient_Organisation_Boss.getMenus()[5])
end