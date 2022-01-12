--[[
  This file is part of FlashLand.
  Created at 10/12/2021 00:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Blips
_FlashServer_Blips = {}

local list = {}

_FlashServer_Blips.set = function(id, blip)
    list[id] = blip
end

_FlashServer_Blips.add = function(blip)
    _FlashServer_Blips.set(blip.id, blip)
end

_FlashServer_Blips.remove = function(id)
    list[id] = nil
end

_FlashServer_Blips.getAmount = function()
    return (_FlashUtils.table_count(list))
end

_FlashServer_Blips.getAll = function()
    return (list)
end

_FlashServer_Blips.get = function(blipId)
    return (list[blipId])
end

_FlashServer_Blips.exists = function(blipId)
    return (list[blipId] ~= nil)
end

_FlashServer_Blips.getNextId = function()
    return (_FlashServer_Blips.getAmount() + 1)
end