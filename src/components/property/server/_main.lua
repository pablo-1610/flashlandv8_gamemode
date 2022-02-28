--[[
  This file is part of FlashLand.
  Created at 26/02/2022 15:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Property
_FlashServer_Property = {}

local propertyList = {}

_FlashServer_Property.exists = function(id)
    return (propertyList[id] ~= nil)
end

_FlashServer_Property.get = function(id)
    if (not (_FlashServer_Property.exists(id))) then
        return (nil)
    end
    return (propertyList[id])
end

_FlashServer_Property.getAll = function()
    return (propertyList)
end

_FlashServer_Property.add = function(property)
    propertyList[property.id] = property
end

_FlashServer_Property.remove = function(id)
    propertyList[id] = nil
end

_FlashLand.loadedComponent("property")