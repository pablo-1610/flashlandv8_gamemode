--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_PlayerMenu.drawer[1] = function()
    RageUI.Button("Inventaire", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[2])
    RageUI.Button("Portefeuille", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[3])
    RageUI.Button("Animations", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[4])
end