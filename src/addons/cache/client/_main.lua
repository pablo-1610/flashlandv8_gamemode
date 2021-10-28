--[[
  This file is part of FlashLand.
  Created at 28/10/2021 15:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Cache = {}

local caches = {}

_FlashClient_Cache.setCache = function(cacheId, value)
    caches[cacheId] = value
end

_FlashClient_Cache.getCache = function(cacheId)
    return (caches[cacheId])
end