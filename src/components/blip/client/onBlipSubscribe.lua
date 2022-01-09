--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param lightBlip _LightBlip
--[[
_FlashLand.onReceive("blip:subscribe", function(lightBlip)
    lightBlip = _LightBlip(lightBlip.id, lightBlip.position, lightBlip.sprite, lightBlip.color, lightBlip.size, lightBlip.label, lightBlip.shortRange, lightBlip.visualData)
    _FlashClient_Blip.set(lightBlip.id, lightBlip)
end)
--]]