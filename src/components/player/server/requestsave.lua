--[[
  This file is part of FlashLand.
  Created at 11/11/2021 15:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("player:requestSave", function()
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("Tentative de save sur un player inexistant (^3%s^7)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    player:savePosition()
    player:saveData()
    player:serverResponded()
    player:sendSystemMessage("success", "Vos informations ont été sauvegardées")
end)