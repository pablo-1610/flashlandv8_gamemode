--[[
  This file is part of FlashLand.
  Created at 09/11/2021 00:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashClient_RichPresence.initialize(_ConfigClient.RichPresence.appId)
end)