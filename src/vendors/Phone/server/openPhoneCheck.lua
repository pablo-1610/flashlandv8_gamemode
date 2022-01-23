--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:43
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function getPlayerPhoneData(flashId)
    local data
    _FlashServer_Database.query("SELECT * FROM flash_players_phone WHERE flashId = @flashId", {
        ["flashId"] = flashId
    }, function(result)
        data = result[1]
    end)
    Wait(1000)
    return data
end

_FlashLand.onReceive("phone:openPhoneCheck", function()
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    if (not (_FlashServer_Items.exists(_ConfigPhone.phoneItemName:lower()))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        return
    end
    local data = getPlayerPhoneData(player.flashId)
    _FlashLand.toClient("phone:playerOpenPhone", _src, data)
end)