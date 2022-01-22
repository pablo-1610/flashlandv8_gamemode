--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:49
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("phone:playerOpenPhone", function(information)
    local playerData = _FlashClient_Cache.getPlayer()
    playerData.charinfo = information
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = "open",
        Tweets = {},
        AppData = _ConfigPhone.applications,
        CallData = {},
        PlayerData = playerData,
    })

    _FlashClient_Phone.openPhone()

    if (not (_FlashClient_Phone.playerIsCall())) then
        _FlashClient_Phone.setAnimationPhone("cellphone_text_in")
    else
        _FlashClient_Phone.setAnimationPhone("cellphone_call_to_text")
    end

    SetTimeout(250, function()
        _FlashClient_Phone.setPhoneProp()
    end)
end)