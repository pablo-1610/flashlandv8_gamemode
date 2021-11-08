--[[
  This file is part of FlashLand.
  Created at 08/11/2021 23:24
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    SetRoutingBucketEntityLockdownMode(_FlashServer_Instances.getPublicInstance(), _ConfigServer.Citizens.lockdown and "strict" or "inactive")
end)