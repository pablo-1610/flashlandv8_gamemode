--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Blip.destroyInGameBlip = function(blipId)
    if (not (_FlashClient_Blip.exists(blipId))) then
        return
    end
    local blip = _FlashClient_Blip.get(blipId)
    if (not (blip.handler)) then
        return
    end
    local radiusBlip = _FlashClient_Blip.radiusBlips[blip.handler]
    if (radiusBlip) then
        RemoveBlip(radiusBlip)
        _FlashClient_Blip.radiusBlips[blip.handler] = nil
    end
    RemoveBlip(blip.handler)
end