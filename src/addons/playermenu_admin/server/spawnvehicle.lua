--[[
  This file is part of FlashLand.
  Created at 20/11/2021 15:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("admin:spawnVehicle", function(model, sendInto)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err("Tentative de admin:spawnVehicle sans player")
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.vehspawn"))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.DENIED_ADMIN_PERMISSION)
        return
    end
    local ped = player:getPed()
    local currentVehicle = GetVehiclePedIsIn(ped, false)
    if currentVehicle ~= nil then
        DeleteEntity(currentVehicle)
    end
    local car = CreateVehicle(model, GetEntityCoords(ped), GetEntityHeading(ped), true, false)
    if (sendInto) then
        TaskWarpPedIntoVehicle(ped, car, -1)
    end
    player:serverResponded()
end)