--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:50
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("zone:unsubscribe", function(lightZoneId)
    _FlashClient_Zone.remove(lightZoneId)
end)