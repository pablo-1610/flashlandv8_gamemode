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
        self.content = {}
        -- Validator
        for type, qty in pairs(content) do
            if (_FlashServer_Items.exists(type)) then
                self.content[type] = qty
            end
        end
        return self
    end
})

function _Inventory:hasItem(itemId)
    return (self.content[itemId] ~= nil and self.content[itemId] >= 1)
end

function _Inventory:getItem(itemId)
    if (not (self:hasItem(itemId))) then
        _FlashLand.err(("Tentative de getItem un item inexistant (^3%s^7|^3%s^7)"):format(itemId, qty))
        return
    end
    return (_FlashServer_Items.get(itemId))
end

function _Inventory:destroy()
    _FlashServer_Inventory.remove(self.id)
end

function _Inventory:removeItem(itemId, qty, cb)
    if (not (self:hasItem(itemId))) then
        _FlashLand.err(("Tentative de removeItem un item inexistant (^3%s^7|^3%s^7)"):format(itemId, qty))
        if (cb ~= nil) then
            cb(false)
        end
        return
    end
    self.content[itemId] = (self.content[itemId] - qty)
    if (self.content[itemId] <= 0) then
        self.content[itemId] = nil
    end
    self:save()
    if (cb ~= nil) then
        cb(true)
    end
end

function _Inventory:addItem(itemId, qty, cb)
    if(not (_FlashServer_Items.exists(itemId))) then
        _FlashLand.err(("Tentative d'ajouter un item inexistant (^3%s^7)"):format(self.id))
        if (cb ~= nil) then
            cb(false)
        end
        return
    end
    local fakeContent = {}
    for k, v in pairs(self.content) do
        fakeContent[k] = v
    end
    if (not (self:hasItem(itemId))) then
        fakeContent[itemId] = 0
    end
    fakeContent[itemId] = (fakeContent[itemId]+qty)
    local fakeWeight = self:calcWeight(fakeContent)
    if (fakeWeight > self.capacity) then
        if (cb ~= nil) then
            cb(false)
        end
        return
    else
        self.content = fakeContent
        self:save()
        if (cb ~= nil) then
            cb(true)
        end
    end
end

function _Inventory:calcWeight(fakeContent)
    local total = 0.00
    for name, qty in pairs(fakeContent ~= nil and fakeContent or self.content) do
        local weight = _FlashServer_Items.get(name).weight
        total = (total + (weight*qty))
    end
    return total
end

function _Inventory:save()
    local currentId, currentCapacity, currentContent = self.id, self.capacity, json.encode(self.content)
    _FlashServer_Database.execute("UPDATE flash_inventory SET inventory_capacity = @inventory_capacity, inventory_content = @inventory_content WHERE inventory_owner = @inventory_owner", {
        ["inventory_capacity"] = currentCapacity,
        ["inventory_content"] = currentContent,
        ["inventory_owner"] = currentId
    })
end