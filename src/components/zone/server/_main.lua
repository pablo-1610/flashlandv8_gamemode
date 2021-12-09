--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Zones
_FlashServer_Zones = {}

local list = {}

---@param zone _Zone
_FlashServer_Zones.set = function(id, zone)
    list[id] = zone
end

---@param zone _Zone
_FlashServer_Zones.add = function(zone)
    _FlashServer_Zones.set(zone.id, zone)
end

_FlashServer_Zones.get = function(zoneId)
    return (list[zoneId])
end

_FlashServer_Zones.getAll = function()
    return (list)
end

_FlashServer_Zones.getAmount = function()
    return (#list)
end

_FlashServer_Zones.getNextId = function()
    return (_FlashServer_Zones.getAmount() + 1)
end

_FlashServer_Zones.exists = function(zoneId)
    return (list[zoneId] ~= nil)
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    CreateThread(function()
        while (true) do
            Wait(500)
            -- TODO -> Implement zones
        end
    end)
end)

_FlashLand.loadedComponent("zone")