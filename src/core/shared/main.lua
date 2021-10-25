--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

--[[
  This file is part of FlashLand.

  Copyright (c) FlashLand - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashLand
_FlashLand = {}

---@type table<string, boolean>
local registredEvents = {}

---registerEvent
---@param event string
---@return nil
---@public
local function registerEvent(event)
    RegisterNetEvent(event)
    table.insert(registredEvents, event)
end

---isEventRegistred
---@param event string
---@return boolean
---@public
local isEventRegistred = function(event)
    for _, eventName in pairs(registredEvents) do
        if (eventName == event) then
            return true
        end
    end
    return false
end

_FlashLand.toInternal = function(event, ...)
    _FlashLand.log(("Envoie d'un event interne: ^3%s^7"):format(event))
    TriggerEvent(_FlashLand.format(event), ...)
end

_FlashLand.toInternalExposed = function(event, ...)
    _FlashLand.log(("Envoie d'un event interne: ^3%s^7"):format(event))
    TriggerEvent(event, ...)
end

_FlashLand.onReceive = function(event, handler)
    event = _FlashLand.format(event)
    if (not (isEventRegistred(event))) then
        registerEvent(event)
    end
    AddEventHandler(event, handler)
end

_FlashLand.onReceiveExposed = function(event, handler)
    if (not (isEventRegistred(event))) then
        registerEvent(event)
    end
    AddEventHandler(event, handler)
end

_FlashLand.onReceiveWithoutNetExposed = function(event, handler)
    AddEventHandler(event, handler)
end

_FlashLand.onReceiveWithoutNet = function(event, handler)
    event = _FlashLand.format(event)
    AddEventHandler(event, handler)
end

_FlashLand.format = function(string)
    return ("FL_%s"):format(GetHashKey(string))
end

_FlashLand.log = function(string)
    if (_Config.environment == _FlashEnum_ENV.DEV) then
        print(("%s %s^7"):format(_Config.prefix, string))
    end
end

_FlashLand.countTable = function(table)
    local i = 0
    for k, v in pairs(table) do
        i = (i + 1)
    end
    return i
end