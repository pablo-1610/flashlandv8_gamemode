--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local weather = "EXTRASUNNY"
local weatherOverride
local running = false

local intervalForAChange = 60000

local function changeWeather()
    -- TODO: Faire le changement de météo
end

_FlashServer_Synchronizer.destroyWeatherThread = function()
    if (not (running)) then
        return
    end
    running = false
    _FlashLand.log("Arrêt du synchronisateur de météo")
end

_FlashServer_Synchronizer.isWeatherSynchronizerRunning = function()
    return (running == true)
end

_FlashServer_Synchronizer.getWeather = function()
    return (weatherOverride ~= nil and weatherOverride or weather)
end

_FlashServer_Synchronizer.overrideWeather = function(weather)
    weatherOverride = weather
end

_FlashLand.onReceive("synchronizer:getWeather", function()
    local _src = source
    _FlashLand.toClient("synchronizer:setWeather", _src, _FlashServer_Synchronizer.getWeather())
end)
