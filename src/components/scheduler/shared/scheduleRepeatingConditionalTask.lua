--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashScheduler.scheduleRepeatingConditionalTask = function(onRun, onStopped, condition, delay, interval)
    _FlashLand.log(("Creation d'un scheduler sur ^2%ims"):format(delay))
    CreateThread(function()
        Wait(delay)
        while (condition()) do
            onRun()
            Wait(interval)
        end
        onStopped()
    end)
end