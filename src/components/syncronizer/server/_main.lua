--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Synchronizer = {}

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Synchronizer.createTimeThread()
    _FlashServer_Synchronizer.createPositionsThread()
end)

_FlashLand.loadedComponent("synchronizer")