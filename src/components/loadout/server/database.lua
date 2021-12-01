--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Loadout.existsInDb = function(loadoutId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_loadout WHERE loadout_owner = @loadoutId", {
        ["loadoutId"] = loadoutId
    }, function(result)
        cb(result[1] ~= nil)
    end)
end

_FlashServer_Loadout.createInDb = function(loadoutId, type, capacity, cb)
    _FlashServer_Database.insert("INSERT INTO flash_loadout (loadout_owner, loadout_type, loadout_capacity, loadout_content) VALUES(@loadoutId, @type, @capacity, \"[]\")", {
        ["loadoutId"] = loadoutId,
        ["type"] = type,
        ["capacity"] = capacity
    })
    _FlashLand.log(("Loadout créé en base de donnée ^6>^5 %s"):format(loadoutId))
    if (cb) then
        return (_FlashServer_Loadout.add(loadoutId, type, capacity, {}, true))
    end
end

_FlashServer_Loadout.loadFromDb = function(loadoutId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_loadout WHERE loadout_owner = @loadoutId", {
        ["loadoutId"] = loadoutId
    }, function(result)
        if (result[1] == nil) then
            _FlashLand.err(("Chargement de loadout (^3%s^7) impossible"):format(inventoryId))
            return
        end
        local row = result[1]
        local loadout = _FlashServer_Loadout.add(row.loadout_owner, row.loadout_type, row.loadout_capacity, json.decode(row.loadout_content), true)
        if (cb ~= nil) then
            cb(loadout)
        end
    end)
end