--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("npc:unsubscribe", function(lightNpcId)
    _FlashClient_Npc.remove(lightNpcId)
end)