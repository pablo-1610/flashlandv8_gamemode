--[[
  This file is part of FlashLand.
  Created at 11/01/2022 18:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.createOrganisation = function(jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blipName, blipColor, blipId, blipPos, callback)
    if (_FlashServer_Organisation.exist(jobName)) then
        return callback(false)
    end
    local blipSave = { name = blipName, color = blipColor, id = blipId, pos = blipPos }
    _FlashServer_Database.insert("INSERT INTO flash_orga (name, label, boss, safe, spawn_vehicle, del_vehicle, blip) VALUES (@name, @label, @boss, @safe, @spawn_vehicle, @del_vehicle, @blip)", {
        ["name"] = jobName,
        ["label"] = jobLabel,
        ["boss"] = json.encode(bossPos),
        ["safe"] = json.encode(safePos),
        ["spawn_vehicle"] = json.encode(spawnVehiclePos),
        ["del_vehicle"] = json.encode(delVehiclePos),
        ["blip"] = json.encode(blipSave),
    }, function()
        ---@type _Orga
        local orga = _Orga(jobName, jobLabel, bossPos, safePos, spawnVehiclePos, delVehiclePos, blipSave)
        _FlashServer_Organisation.add(orga)
        callback(true)
    end)
end