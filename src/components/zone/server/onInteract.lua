--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local deSyncFactor = 1.5

_FlashLand.onReceive("zone:interact", function(zoneId)
    local _src = source
    local playerCoords = GetEntityCoords(GetPlayerPed(_src))
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    if (not (_FlashServer_Zones.exists(zoneId))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ZONE_NOT_EXISTS)
        return
    end
    ---@type _Zone
    local zone = _FlashServer_Zones.get(zoneId)
    if (#(zone.location - playerCoords) > (zone.itrDist + deSyncFactor)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ZONE_TOO_FAR)
        return
    end
    zone:interact(_src)
end)