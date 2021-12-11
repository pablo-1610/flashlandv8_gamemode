--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNetExposed("playerDropped", function()
    local _src = source
    ---@param zone _Zone
    for _, zone in pairs(_FlashServer_Zones.getAll()) do
        if (zone:isAllowed(_src)) then
            zone:removeAllowed(_src)
        end
        if (zone:isSubscribed(_src)) then
            zone:unsubscribe(_src, true)
        end
    end
end)