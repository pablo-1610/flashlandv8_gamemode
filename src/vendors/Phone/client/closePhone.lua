--[[
  This file is part of FlashLand.
  Created at 22/01/2022 20:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback('Close', function()
    if (_FlashClient_Phone.playerIsCall()) then
        _FlashClient_Phone.setAnimationPhone('cellphone_text_out')
        SetTimeout(400, function()
            StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_out", 2.5)
            _FlashClient_Phone.deletePhone()
        end)
    else
        _FlashClient_Phone.setAnimationPhone("cellphone_text_to_call")
    end
    SetNuiFocus(false, false)
    SetTimeout(1000, function()
        _FlashClient_Phone.closePhone()
    end)
end)
