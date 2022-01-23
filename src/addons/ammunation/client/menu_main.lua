--[[
  This file is part of FlashLand.
  Created at 15/12/2021 15:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Ammunation.drawer[1] = function(player)
    RageUI.Button("Acheter des armes", nil, { RightLabel = "→" }, true, {}, _FlashClient_Ammunation.getMenus()[2])
end