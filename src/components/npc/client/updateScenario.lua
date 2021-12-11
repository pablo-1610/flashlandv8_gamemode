--[[
  This file is part of FlashLand.
  Created at 10/12/2021 15:39
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("npc:updateScenario", function(lightNpcId, scenario)
    if (not (_FlashClient_Npc.exists(lightNpcId))) then
        return
    end
    if (not (_FlashClient_Npc.hasHandler(lightNpcId, "onSay"))) then
        return
    end
    local handler = _FlashClient_Npc.getHandler(lightNpcId)
    if (scenario.instantly) then
        ClearPedTasksImmediately(handler)
    else
        ClearPedTasks(handler)
    end
    TaskStartScenarioInPlace(handler, scenario.name, 0, not (scenario.instantly))
end)