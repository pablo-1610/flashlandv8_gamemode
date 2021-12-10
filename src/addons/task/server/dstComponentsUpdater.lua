--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashScheduler.scheduleRepeatingTask(function()
        _FlashServer_Task.doZoneUpdater()
        _FlashServer_Task.doNpcUpdater()
    end, 2000, 1000)
end)