--[[
  This file is part of FlashLand.
  Created at 29/10/2021 02:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_Zone
_FlashClient_Zone = {}

local list = {}

_FlashClient_Zone.getAmount = function()
    return (_FlashUtils.table_count(list))
end

_FlashClient_Zone.getAll = function()
    return (list)
end

_FlashClient_Zone.remove = function(lightZoneId)
    list[lightZoneId] = nil
end

_FlashClient_Zone.set = function(lightZoneId, lightZone)
    list[lightZoneId] = lightZone
    _FlashClient_Zone.tryInvokeDrawer()
end

_FlashClient_Zone.get = function(lightZoneId)
    return (list[lightZoneId])
end

_FlashClient_Zone.coolDown = false

_FlashLand.loadedComponent("zone")