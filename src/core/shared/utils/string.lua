--[[
  This file is part of FlashLand.
  Created at 11/11/2021 13:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashUtils.string_startsWith = function(str, start)
    return (string.sub(str,1,string.len(start))==start)
end

_FlashUtils.string_split = function(str, delimiter)
    result = {};
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end