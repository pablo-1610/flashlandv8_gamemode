--[[
  This file is part of FlashLand.
  Created at 10/12/2021 16:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNetExposed("playerDropped", function()
    local _src = source
    ---@param npc _Blip
    for _, npc in pairs(_FlashServer_Npc.getAll()) do
        if (npc:isSubscribed(_src)) then
            npc:unsubscribe(_src, true)
        end
    end
end)