--[[
  This file is part of FlashLand.
  Created at 13/12/2021 22:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:spawnPlayerSelectedVehicule", function(targetSource, model)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:giveWeapon sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.giveitem"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_SELECTED_IS_INVALID)
        player:serverResponded()
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSource)
    local ped = target:getPed()
    local currentVehicle = GetVehiclePedIsIn(ped, false)
    if currentVehicle ~= nil then
        DeleteEntity(currentVehicle)
    end
    local car = CreateVehicle(model, GetEntityCoords(ped), GetEntityHeading(ped), true, false)
    TaskWarpPedIntoVehicle(ped, car, -1)
    player:serverResponded()
end)