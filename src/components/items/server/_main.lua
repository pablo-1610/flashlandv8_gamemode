--[[
  This file is part of FlashLand.
  Created at 08/11/2021 22:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Items
_FlashServer_Items = {}

local list = {}

---@param item _Item
_FlashServer_Items.add = function(item)
    _FlashLand.log(("Ajout d'un item: ^3%s"):format(item.label))
    list[item.id] = item
end

_FlashServer_Items.exists = function(itemId)
    return (list[itemId] ~= nil)
end

_FlashServer_Items.get = function(itemId)
    if (not (_FlashServer_Items.exists(itemId))) then
        return nil
    end
    return (list[playerId])
end

_FlashServer_Items.getAll = function()
    return (list)
end

_FlashServer_Items.setUsage = function(itemId, onUse)
    if (not (_FlashServer_Items.exists(itemId))) then
        _FlashLand.err(("Tentative de setUsage sur un item invalide (^3%s^7)"):format(itemId))
        return
    end
    ---@type _Item
    local item = _FlashServer_Items.get(itemId)
    item.onUse = function(_src)
        onUse(_src)
    end
end

_FlashLand.loadedComponent("items")