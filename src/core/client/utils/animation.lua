--[[
  This file is part of FlashLand.
  Created at 08/12/2021 23:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashClient_Utils.animation_load = function(dict)
     RequestAnimDict(dict)
     while not HasAnimDictLoaded(dict) do
        Wait(1)
     end
end

_FlashClient_Utils.process_load = function(name)
    RequestAnimSet(name)
    while not HasAnimSetLoaded(name) do
        Wait(1)
    end
end