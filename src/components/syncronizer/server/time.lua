--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local time = _ConfigServer.Synchronizer.baseTime
local timeOverride
local running = false
local intervalForAMin = _ConfigServer.Synchronizer.time

local function incrementTime()
    time[2] = (time[2]+1)
    if (time[2] >= 60) then
        time[2] = 0
        time[1] = (time[1]+1)
        if (time[1] >= 24) then
            time[1] = 0
        end
    end
end

_FlashServer_Synchronizer.createTimeThread = function()
    if (running) then
        return
    end
    running = true
    CreateThread(function()
        while (running) do
            Wait(intervalForAMin)
            incrementTime()
            _FlashLand.toClients("synchronizer:setTime", _FlashServer_Synchronizer.getTime())
        end
    end)
end

_FlashServer_Synchronizer.destroyTimeThread = function()
    if (not (running)) then
        return
    end
    running = false
    _FlashLand.log("Arrêt du synchronisateur de temps")
end

_FlashServer_Synchronizer.isTimeSynchronizerRunning = function()
    return (running == true)
end

_FlashServer_Synchronizer.getTime = function()
    return (timeOverride ~= nil and timeOverride or time)
end

_FlashServer_Synchronizer.overrideTime = function(h, m)
    timeOverride = {h,m}
end

_FlashLand.onReceive("synchronizer:getTime", function()
    local _src = source
    _FlashLand.toClient("synchronizer:setTime", _src, _FlashServer_Synchronizer.getTime())
end)