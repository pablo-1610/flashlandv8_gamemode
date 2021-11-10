--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Inventory.existsInDb = function(inventoryId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_inventory WHERE inventory_owner = @inventoryId", {
        ["inventoryId"] = inventoryId
    }, function(result)
        cb(result[1] ~= nil)
    end)
end

_FlashServer_Inventory.createInDb = function(inventoryId, type, label, capacity, cb)
    _FlashServer_Database.insert("INSERT INTO flash_inventory (inventory_owner, inventory_type, inventory_label, inventory_capacity, inventory_content) VALUES(@inventoryId, @type, @label, @capacity, \"[]\")", {
        ["inventoryId"] = inventoryId,
        ["type"] = type,
        ["label"] = label,
        ["capacity"] = capacity
    })
    _FlashLand.log(("Inventaire créé en base de donnée ^6>^5 %s"):format(label))
    if (cb) then
        return (_FlashServer_Inventory.add(inventoryId, type, label, capacity, {}, true))
    end
end

_FlashServer_Inventory.loadFromDb = function(inventoryId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_inventory WHERE inventory_owner = @inventoryId", {
        ["inventoryId"] = inventoryId
    }, function(result)
        if (result[1] == nil) then
            _FlashLand.err(("Chargement d'inventaire (^3%s^7) impossible"):format(inventoryId))
            return
        end
        local row = result[1]
        local inventory = _FlashServer_Inventory.add(row.inventory_owner, row.inventory_type, row.inventory_label, row.inventory_capacity, json.decode(row.inventory_content), true)
        if (cb ~= nil) then
            cb(inventory)
        end
    end)
end