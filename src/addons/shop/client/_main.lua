--[[
  This file is part of FlashLand.
  Created at 12/12/2021 13:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_Shop
_FlashClient_Shop = {}

_FlashClient_Shop.var = {
    basket = nil,
    categories = nil,
    selectedCategory = nil,
    points = nil
}

_FlashClient_Shop.getItemPrice = function(itemId)
    for _, category in pairs(_FlashClient_Shop.var.categories) do
        for _, item in pairs(category.content) do
            if (itemId == item.item) then
                return item.price
            end
        end
    end
    return nil
end

_FlashClient_Shop.getItemLabel = function(itemId)
    for _, category in pairs(_FlashClient_Shop.var.categories) do
        for _, item in pairs(category.content) do
            if (itemId == item.item) then
                return item.label
            end
        end
    end
    return nil
end

_FlashClient_Shop.getItemCount = function(itemId)
    return (_FlashClient_Shop.var.basket[itemId] or 0)
end

_FlashClient_Shop.isItemInBasket = function(itemId)
    return (_FlashClient_Shop.var.basket[itemId] ~= nil)
end

_FlashClient_Shop.calculateTotalPrice = function()
    local total = 0
    for itemId, count in pairs(_FlashClient_Shop.var.basket) do
        total = total + (_FlashClient_Shop.getItemPrice(itemId) * count)
    end
    return total
end

_FlashClient_Shop.isAnyItemInBasket = function()
    return (next(_FlashClient_Shop.var.basket) ~= nil)
end

_FlashClient_Shop.addItemToBasket = function(itemId)
    if (not (_FlashClient_Shop.var.basket[itemId])) then
        _FlashClient_Shop.var.basket[itemId] = 0
    end
    _FlashClient_Shop.var.basket[itemId] = _FlashClient_Shop.var.basket[itemId] + 1
end