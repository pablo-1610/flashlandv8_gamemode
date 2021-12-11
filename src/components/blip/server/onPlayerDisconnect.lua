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
    ---@param blip _Blip
    for _, blip in pairs(_FlashServer_Blips.getAll()) do
        if (blip:isAllowed(_src)) then
            blip:removeAllowed(_src)
        end
        if (blip:isSubscribed(_src)) then
            blip:unsubscribe(_src, true)
        end
    end
end)