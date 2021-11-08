--[[
  This file is part of FlashLand.
  Created at 08/11/2021 22:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightItem
---@field public id number
---@field public label string
---@field public description string
---@field public weight number
---@field public usable boolean
_LightItem = {}
_LightItem.__index = _LightItem

setmetatable(_LightItem, {
    __call = function(_, id, label, description, weight, usable)
        local self = setmetatable({}, _LightItem)
        self.id = id
        self.label = label
        self.description = description
        self.weight = weight
        self.usable = usable
        return self
    end
})