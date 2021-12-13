--[[
  This file is part of FlashLand.
  Created at 12/12/2021 19:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashClient_PlayerMenu.drawer[18] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayerAction ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayerAction]
        -- TODO -> Recup la liste des armes pour pour pouvoir les afficher et les gives !
    end
end