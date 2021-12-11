--[[
  This file is part of FlashLand.
  Created at 10/12/2021 16:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightBlip
---@field public id number
---@field public position table
---@field public sprite number
---@field public color number
---@field public size number
---@field public label string
---@field public shortRange boolean
_LightBlip = {}
_LightBlip.__index = _LightBlip

setmetatable(_LightBlip, {
    __call = function(_, id, position, sprite, color, size, label, shortRange)
        local self = setmetatable({}, _LightBlip)
        self.id = id
        self.position = position
        self.sprite = sprite
        self.color = color
        self.size = size
        self.label = label
        self.shortRange = shortRange
        return (self)
    end
})