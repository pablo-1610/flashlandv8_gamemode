--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("blip:receiveFirstBlips", function(blips)
    _FlashClient_Blip.setAll(blips)
end)