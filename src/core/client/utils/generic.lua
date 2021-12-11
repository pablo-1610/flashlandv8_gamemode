--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.generic_getSexDisplay = function(sex)
    return (sex == 0 and "Mr" or "Mme")
end