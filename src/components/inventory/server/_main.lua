--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:43
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Inventory
_FlashServer_Inventory = {}

local list = {}

_FlashServer_Inventory.exists = function(inventoryId)
    return (list[inventoryId] ~= nil)
end

_FlashServer_Inventory.get = function(inventoryId)
    if (not (_FlashServer_Inventory.exists(inventoryId))) then
        _FlashLand.err(("Tentative de get un inventaire inexistant (^3%s^7)"):format(inventoryId))
        return
    end
    return (list[inventoryId])
end

_FlashServer_Inventory.getAll = function()
    return (list)
end

_FlashServer_Inventory.add = function(id, type, label, capacity, content, cb)
    if (_FlashServer_Inventory.exists(id)) then
        _FlashLand.err(("Tentative de créer un inventaire existant (^3%s^7)"):format(id))
        return
    end
    local inventory = _Inventory(id, type, label, capacity, content)
    list[id] = inventory
    if(cb) then
        return inventory
    end
end

_FlashServer_Inventory.remove = function(id)
    if (not (_FlashServer_Inventory.exists(id))) then
        _FlashLand.err(("Tentative de supprimer un inventaire inexistant (^3%s^7)"):format(id))
        return
    end
    list[id] = nil
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_inventory WHERE flash_inventory.inventory_type = 2", {}, function(result)
        for _, row in pairs(result) do

        end
    end)
end)

