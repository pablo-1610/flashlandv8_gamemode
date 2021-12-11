--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:50
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param lightZone _LightZone
_FlashLand.onReceive("zone:subscribe", function(lightZone)
    lightZone = _LightZone(lightZone.id, lightZone.location, lightZone.color, lightZone.helpText, lightZone.itrDist, lightZone.hideIfAMenuIsOpen)
    _FlashClient_Zone.set(lightZone.id, lightZone)
end)