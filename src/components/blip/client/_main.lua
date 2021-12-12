--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:34
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_Blip
_FlashClient_Blip = {}

_FlashClient_Blip.radiusBlips = {}

local list = {}

_FlashClient_Blip.getAmount = function()
    return (_FlashUtils.table_count(list))
end

_FlashClient_Blip.getAll = function()
    return (list)
end

_FlashClient_Blip.get = function(blipId)
    return (list[blipId])
end

_FlashClient_Blip.exists = function(blipId)
    return (list[blipId] ~= nil)
end

_FlashClient_Blip.set = function(lightBlipId, lightBlip)
    if (_FlashClient_Blip.exists(lightBlipId)) then
        lightBlip.handler = list[lightBlipId].handler
        list[lightBlipId] = lightBlip
        return
    end
    list[lightBlipId] = lightBlip
    print(json.encode(lightBlip))
    _FlashClient_Blip.createInGameBlip(lightBlip)
end

_FlashClient_Blip.remove = function(blipId)
    _FlashClient_Blip.destroyInGameBlip(blipId)
    list[blipId] = nil
end