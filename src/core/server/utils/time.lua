--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Utils.time_getCurrentTimeFormattedFR = function()
    local time = os.date("*t")
    local hour = time.hour
    local minute = time.min
    local second = time.sec
    local day = time.day
    local month = time.month
    local year = time.year
    local formattedTime = ""
    if hour < 10 then
        hour = "0" .. hour
    end
    if minute < 10 then
        minute = "0" .. minute
    end
    if second < 10 then
        second = "0" .. second
    end
    if day < 10 then
        day = "0" .. day
    end
    if month < 10 then
        month = "0" .. month
    end
    if year < 10 then
        year = "0" .. year
    end
    formattedTime = hour .. ":" .. minute .. ":" .. second .. " " .. day .. "/" .. month .. "/" .. year
    return formattedTime
end