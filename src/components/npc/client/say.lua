--[[
  This file is part of FlashLand.
  Created at 10/12/2021 15:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("npc:say", function(lightNpcId, speech, param)
    if (not (_FlashClient_Npc.exists(lightNpcId))) then
        return
    end
    if (not (_FlashClient_Npc.hasHandler(lightNpcId, "onSay"))) then
        return
    end
    PlayAmbientSpeech1(_FlashClient_Npc.getHandler(lightNpcId), speech, param)
end)