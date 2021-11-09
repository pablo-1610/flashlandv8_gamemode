--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:21
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Players
_FlashServer_Players = {}

local list = {}

---@param player _Player
_FlashServer_Players.isNew = function(player)
    return (player.identity == nil)
end

_FlashServer_Players.exists = function(playerId)
    return (list[playerId] ~= nil)
end

_FlashServer_Players.existsInDb = function(_src)
    local license = _FlashServer_Utils.identifiers_get(_src, "license")
    _FlashServer_Database.query("SELECT * FROM flash_players WHERE identifier = @identifier", { ["identifier"] = license }, function(result)
        return (result[1] ~= nil)
    end)
end

_FlashServer_Players.get = function(playerId)
    if (not (_FlashServer_Players.exists(playerId))) then
        return nil
    end
    return (list[playerId])
end

_FlashServer_Players.getAll = function()
    return (list)
end

---@param player _Player
_FlashServer_Players.add = function(player)
    --_FlashLand.log(("^2Ajout ^7d'un ^6PLAYER ^7id: ^3%s"):format(player.sId))
    list[player.sId] = player
end

_FlashServer_Players.remove = function(playerId)
    --_FlashLand.log(("^1Suppression ^7d'un ^6PLAYER ^7id: ^3%s"):format(list[playerId].sId))
    list[playerId] = nil
end

_FlashServer_Players.loadData = function(_src, cb)
    local identifier = _FlashServer_Utils.identifiers_get(_src, "license")
    _FlashServer_Database.query("SELECT * FROM flash_players WHERE identifier = @identifier", { ["identifier"] = identifier }, function(result)
        cb(result[1])
    end)
end

_FlashLand.loadedComponent("player")