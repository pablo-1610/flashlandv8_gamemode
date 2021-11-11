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
        return self
    end
})

function _Inventory:destroy()
    _FlashServer_Inventory.remove(self.id)
end

function _Inventory:save()
    local currentId, currentCapacity, currentContent = self.id, self.capacity, json.encode(self.content)
    _FlashServer_Database.execute("UPDATE flash_inventory SET inventory_capacity = @inventory_capacity, inventory_content = @inventory_content WHERE inventory_owner = @inventory_owner", {
        ["inventory_capacity"] = currentCapacity,
        ["inventory_content"] = currentContent,
        ["inventory_owner"] = currentId
    })
end