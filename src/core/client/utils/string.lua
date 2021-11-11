--[[
  This file is part of FlashLand.
  Created at 11/11/2021 13:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.string_startsWith = function(str, start)
    return (string.sub(str,1,string.len(start))==start)
end