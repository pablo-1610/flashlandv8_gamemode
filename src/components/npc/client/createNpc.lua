--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param lightNpc _LightNpc
_FlashClient_Npc.createNpc = function(lightNpc)
    local model = GetHashKey(lightNpc.model)
    _FlashClient_Utils.memory_load(model, true, true)
    local ped = CreatePed(4, model, lightNpc.position.x, lightNpc.position.y, lightNpc.position.z, lightNpc.heading)
    SetEntityAsMissionEntity(ped)
    SetEntityInvincible(ped, true)
    if (lightNpc.frozen) then
        FreezeEntityPosition(ped, true)
    end
    if (lightNpc.visualData.weapon) then
        GiveWeaponToPed(ped, GetHashKey(lightNpc.visualData.weapon), 1000, false, true)
        SetCurrentPedWeapon(ped, GetHashKey(lightNpc.visualData.weapon), true)
    end
    if (lightNpc.visualData.scenario) then
        TaskStartScenarioInPlace(ped, lightNpc.visualData.scenario.name, 0, not (lightNpc.visualData.scenario.instantly))
    end
    if (not (lightNpc.ai)) then
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
    _FlashClient_Npc.setHandler(lightNpc.id, ped)
    _FlashClient_Utils.memory_unload(model, true)
end