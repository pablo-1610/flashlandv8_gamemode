--[[
  This file is part of FlashLand.
  Created at 18/12/2021 13:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashClient_Barber.drawer[1] = function(player)
    RageUI.Button("Coupe de cheveux", nil, {}, true, {}, _FlashClient_Barber.getMenus()[2])
    RageUI.Button("Barbe", nil, {}, true, {}, _FlashClient_Barber.getMenus()[3])
end