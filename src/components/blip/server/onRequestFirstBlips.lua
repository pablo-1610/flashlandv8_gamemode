--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("blip:requestFirstBlips", function(_src)
    local blips = {}
    ---@param blip _Blip
    for _, blip in pairs(_FlashServer_Blips.getAll()) do
        if (blip.public) then
            blips[blip.id] = blip
        end
    end
    _FlashLand.toClient("blip:receiveFirstBlips", _src, blips)
end)