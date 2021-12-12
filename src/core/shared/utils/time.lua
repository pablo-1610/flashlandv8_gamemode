--[[
  This file is part of FlashLand.
  Created at 11/12/2021 23:34
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashUtils.setTime = function()
    return (os.time())
end

_FlashUtils.decodeTime = function(time)
    local decodeTime = os.date("*t", time)
    return (decodeTime)
end

_FlashUtils.setHour = function()
    local decodeTime = os.date("*t", _FlashUtils.setTime())
    local hour = ("%sh%s"):format(decodeTime.hour, decodeTime.min)
    return (hour)
end

_FlashUtils.setDay = function()
    local decodeTime = os.date("*t", _FlashUtils.setTime())
    local day = ("%s/%s/%s"):format(decodeTime.day, decodeTime.month, decodeTime.year)
    return (day)
end