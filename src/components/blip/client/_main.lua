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

---@param blip _Blip
_FlashClient_Blip.add = function(blip)
    list[blip.id] = blip
    _FlashClient_Blip.createInGameBlip(blip)
end

_FlashClient_Blip.remove = function(blipId)
    list[blipId] = nil
    _FlashClient_Blip.destroyInGameBlip(blipId)
end

_FlashClient_Blip.setAll = function(blips)
    -- Incoming blips
    ---@param newBlip _Blip
    for newBlipId, newBlip in pairs(blips) do
        local found = false
        -- Current blips
        for currentBlipId, _ in pairs(_FlashClient_Blip.getAll()) do
            if (newBlipId == currentBlipId) then
                found = true
                break
            end
        end
        if (not (found)) then
            -- Create new blip
            _FlashClient_Blip.createInGameBlip(newBlip)
        end
    end

    -- Old blips no longer in the incoming blips
    ---@param currentBlip _Blip
    for currentBlipId, currentBlip in pairs(_FlashClient_Blip.getAll()) do
        local found = false
        for newBlipId, _ in pairs(blips) do
            if (currentBlipId == newBlipId) then
                found = true
                break
            end
        end
        if (not (found)) then
            -- Destroy old blip
            _FlashClient_Blip.destroyInGameBlip(currentBlipId)
        end
    end
    list = blips
end