--[[
  This file is part of FlashLand.
  Created at 11/12/2021 23:34
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashUtils.setCurrentTime = function()
    return (os.time())
end

_FlashUtils.getCurrentTime = function()
    local actualTime = os.date("*t")
    return (("%s/%s/%s %sh%s"):format(actualTime.day, actualTime.month, actualTime.year, actualTime.hour, actualTime.min))
end

_FlashUtils.decodeTime = function(timeDecode)
    local actualTime = os.date("*t", timeDecode)
    return (("%s/%s/%s %sh%s"):format(actualTime.day, actualTime.month, actualTime.year, actualTime.hour, actualTime.min))
end