--[[
  This file is part of FlashLand.
  Created at 28/01/2022 12:57
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("phone:deleteContact", function(data)
local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
            return
        end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        player:serverResponded()
        return
    end
    _FlashServer_Database.execute("DELETE FROM flash_phone_contacts WHERE flashId = @flashId AND number = @number", {
        ["flashId"] = player.flashId,
        ["number"] = data.CurrentContactNumber
    })
    player:serverResponded()
end)