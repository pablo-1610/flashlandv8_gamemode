--[[
  This file is part of FlashLand.
  Created at 09/11/2021 22:09
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightInventory
---@field public id number
---@field public type number
---@field public label string
---@field public capacity number
---@field public content table
_LightInventory = {}
_LightInventory.__index = _LightInventory

setmetatable(_LightInventory, {
    __call = function(_, id, type, label, capacity, content)
        local self = setmetatable({}, _LightInventory)
        self.id = id
        self.type = type
        self.label = label
        self.capacity = capacity
        self.content = content
    end
})