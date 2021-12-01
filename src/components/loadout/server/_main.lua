--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:43
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Loadout
_FlashServer_Loadout = {}

local list = {}

_FlashServer_Loadout.exists = function(loadoutId)
    return (list[loadoutId] ~= nil)
end

_FlashServer_Loadout.get = function(loadoutId)
    if (not (_FlashServer_Loadout.exists(loadoutId))) then
        _FlashLand.err(("Tentative de get un loadout inexistant (^3%s^7)"):format(loadoutId))
        return
    end
    return (list[loadoutId])
end

_FlashServer_Loadout.getAll = function()
    return (list)
end

_FlashServer_Loadout.add = function(id, type, capacity, content, cb)
    if (_FlashServer_Loadout.exists(id)) then
        _FlashLand.err(("Tentative de créer un inventaire existant (^3%s^7)"):format(id))
        return
    end
    local loadout = _Loadout(id, type, capacity, content)
    list[id] = loadout
    if(cb) then
        return loadout
    end
end

_FlashServer_Loadout.remove = function(id)
    if (not (_FlashServer_Loadout.exists(id))) then
        _FlashLand.err(("Tentative de supprimer un loadout inexistant (^3%s^7)"):format(id))
        return
    end
    list[id] = nil
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_loadout WHERE flash_loadout.loadout_type = 2", {}, function(result)
        for _, row in pairs(result) do
            -- TODO → Ajouter
        end
    end)
end)

