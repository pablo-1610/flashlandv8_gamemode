--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_PlayerMenu.drawer[2] = function(player)
    if (_FlashLand.countTable(player.inventory.content) <= 0) then
        RageUI.Separator("Votre sac est vide")
        RageUI.Line()
        RageUI.Separator("Rendez-vous dans une ~g~superette ~s~!")
    else

    end
end