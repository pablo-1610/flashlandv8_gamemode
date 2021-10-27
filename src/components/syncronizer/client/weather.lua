--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:54
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local overrideWeather

local function setWeather(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypePersist(weather)
    SetWeatherTypeNowPersist(weather)
end

_FlashClient_Synchronizer.destroyWeatherOverride = function()
    overrideWeather = nil
    _FlashLand.toServer("synchronizer:getWeather")
end

_FlashClient_Synchronizer.setWeatherOverride = function(weather)
    overrideWeather = weather
    setWeather(weather)
end

_FlashLand.onReceiveWithoutNet("joined", function()
    _FlashLand.toServer("synchronizer:getWeather")
end)

_FlashLand.onReceive("synchronizer:setWeather", function(weather)
    if (overrideWeather ~= nil) then
        return
    end
    setWeather(weather)
end)