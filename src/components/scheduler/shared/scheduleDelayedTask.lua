--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashScheduler.scheduleDelayedTask = function(onRun, delay)
    CreateThread(function()
        Wait(delay)
        onRun()
    end)
end