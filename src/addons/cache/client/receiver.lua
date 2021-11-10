--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("cache:setCache", function(k, v)
    if(_FlashClient_Cache.hasSpecialAction(k)) then
        _FlashClient_Cache.doOnReceive(k, v)
        return
    end
    _FlashLand.log(("Définition du cache client %s"):format(k))
    _FlashClient_Cache.setCache(k,v)
end)