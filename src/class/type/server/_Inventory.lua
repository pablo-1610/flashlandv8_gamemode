--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Inventory
---@field public id number
---@field public type number
---@field public label string
---@field public capacity number
---@field public content table
_Inventory = {}
_Inventory.__index = _Inventory

setmetatable(_Inventory, {
    __call = function(_, id, type, label, capacity, content)
        local self = setmetatable({}, _Inventory)
        self.id = id
        self.type = type
        self.label = label
        self.capacity = capacity
        self.content = content
    end
})