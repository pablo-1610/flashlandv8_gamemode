--[[
  This file is part of FlashLand.
  Created at 27/10/2021 19:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.regex_validate = function(str, regex)
    return (string.match(str, regex))
end

_FlashClient_Utils.regex_name = function(name)
    return (_FlashClient_Utils.regex_validate(name, "/^[a-z ,.'-]+$/i"))
end