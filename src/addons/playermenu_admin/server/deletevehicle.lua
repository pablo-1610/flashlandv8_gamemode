--[[
  This file is part of FlashLand.
  Created at 20/11/2021 15:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("admin:deleteVehicle", function(vehicleId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err("Tentative de admin:deleteVehicle sans player")
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.vehdelete"))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.DENIED_ADMIN_PERMISSION)
        return
    end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleId)
    if(not (DoesEntityExist(vehicle))) then
        player:sendSystemMessage("error", _Static_GenericMessages.INVALID_SERVER_ENTITY)
        player:serverResponded()
        return
    end
    DeleteEntity(vehicle)
    player:serverResponded()
end)