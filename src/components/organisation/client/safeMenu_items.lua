--[[
  This file is part of FlashLand.
  Created at 24/02/2022 19:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashClient_Organisation_Safe.drawer[2] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Safe.intraVars.label))
    RageUI.Line()
    RageUI.Button("Prendre item(s)", nil, { RightLabel = "~r~→→" }, true, {}, _FlashClient_Organisation_Safe.getMenus()[4])
    RageUI.Button("Déposer item(s)", nil, { RightLabel = "~r~→→" }, true, {}, _FlashClient_Organisation_Safe.getMenus()[5])
end