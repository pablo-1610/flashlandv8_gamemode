--[[
  This file is part of FlashLand.
  Created at 28/01/2022 12:05
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("phone:saveNewContact", function(data)
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
    _FlashServer_Database.insert("INSERT INTO flash_phone_contacts (flashId, name, number, iban) VALUES (@flashId, @name, @number, @iban)", {
        ["flashId"] = player.flashId,
        ["name"] = data.ContactName,
        ["number"] = data.ContactNumber,
        ["iban"] = data.ContactIban,
    })
    player:serverResponded()
end)