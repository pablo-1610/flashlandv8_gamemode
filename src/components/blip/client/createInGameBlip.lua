--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param blipData _Blip
_FlashClient_Blip.createInGameBlip = function(blipData)
    -- Blip already exists in the player's game
    if (_FlashClient_Blip.exists(blipData.id) and _FlashClient_Blip.get(blipData.id).handle) then
        return
    end
    local blip = AddBlipForCoord(blipData.position.x, blipData.position.y, blipData.position.z)
    SetBlipSprite(blip, blipData.sprite)
    SetBlipColour(blip, blipData.color)
    SetBlipAsShortRange(blip, blipData.shortRange)
    SetBlipScale(blip, blipData.size)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipData.label)
    EndTextCommandSetBlipName(blip)
    blipData.handle = blip
end