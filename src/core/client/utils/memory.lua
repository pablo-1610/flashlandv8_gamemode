--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.memory_load = function(model)
    model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

_FlashClient_Utils.memory_unload = function(model)
    model = GetHashKey(model)
    SetModelAsNoLongerNeeded(model)
end