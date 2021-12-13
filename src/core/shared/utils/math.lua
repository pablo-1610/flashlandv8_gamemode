--[[
  This file is part of FlashLand.
  Created at 15/11/2021 20:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashUtils.math_round = function(number, decimalPlace)
    local mult = 10 ^ (decimalPlace or 0)
    return math.floor(number * mult + 0.5) / mult
end

_FlashUtils.math_group = function(value)
    local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1' .. ","):reverse()) .. right
end

_FlashUtils.math_price = function(value)
    return ("~g~%s$~s~"):format(_FlashUtils.math_group(_FlashUtils.math_round(value, 2)))
end

_FlashUtils.math_price_color = function(value, color)
    return ("%s%s$~s~"):format(color, _FlashUtils.math_group(_FlashUtils.math_round(value, 2)))
end

_FlashUtils.math_getInversedHeading = function(heading)
    return (heading + 180) % 360
end