--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param lightNpc _LightNpc
_FlashLand.onReceive("npc:subscribe", function(lightNpc)
    lightNpc = _LightNpc(lightNpc.id, lightNpc.position, lightNpc.heading, lightNpc.model, lightNpc.ai, lightNpc.frozen, lightNpc.visualData)
    _FlashClient_Npc.set(lightNpc.id, lightNpc)
end)