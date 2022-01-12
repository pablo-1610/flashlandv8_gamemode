--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Ranks
_FlashServer_Ranks = {}

local list = {}
local permissions = {}

local function getLowestRank()
    return (_FlashServer_Ranks.get(_ConfigServer.Start.rank))
end

_FlashServer_Ranks.exists = function(rankId)
    return (list[rankId] ~= nil)
end

_FlashServer_Ranks.add = function(rankId, rank)
    list[rankId] = rank
end

_FlashServer_Ranks.remove = function(rankId)
    if (not (_FlashServer_Ranks.exists(rankId))) then
        return
    end
    list[rankId] = nil
end

_FlashServer_Ranks.get = function(rankId)
    if (not (_FlashServer_Ranks.exists(rankId))) then
        return nil
    end
    return (list[rankId])
end

_FlashServer_Ranks.permissionExist = function(name)
    for _, v in pairs(permissions) do
        if (v == name) then
            return (true)
        end
    end
    return (false)
end

_FlashServer_Ranks.getAllRank = function()
    return (list)
end

_FlashServer_Ranks.getAllPermissions = function()
    return (permissions)
end

_FlashServer_Ranks.addPermission = function(permission)
    if (_FlashServer_Ranks.permissionExist(permission)) then
        return
    end
    table.insert(permissions, permission)
end

_FlashServer_Ranks.removePermission = function(permission)
    if (not (_FlashServer_Ranks.permissionExist(permission))) then
        return
    end
    for index, perm in pairs(permissions) do
        if (perm == permission) then
            table.remove(permissions, index)
        end
    end
end

_FlashServer_Ranks.getOrLowest = function(rankId)
    return (_FlashServer_Ranks.get(rankId) or getLowestRank())
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT flash_ranks.id,flash_ranks.label,flash_ranks.weight,flash_ranks.baseColor,flash_ranks_permissions.permission FROM flash_ranks LEFT JOIN flash_ranks_permissions ON flash_ranks.id = flash_ranks_permissions.rankId", {}, function(result)
        for row, data in pairs(result) do
            if (_FlashServer_Ranks.exists(data.id)) then
                ---@type _Rank
                local rank = _FlashServer_Ranks.get(data.id)
                rank:addPermission(data.permission)
            else
                ---@type _Rank
                local rank = _Rank(data.id, data.label, data.weight, nil, data.baseColor)
                _FlashServer_Ranks.add(data.id, rank)
                _FlashLand.log(("Ajout d'un rang: ^2%s"):format(data.label))
                rank:addPermission(data.permission)
            end
        end
    end)
end)

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT permission FROM flash_ranks_permissions", {}, function(result)
        for _, data in pairs(result) do
            _FlashServer_Ranks.addPermission(data.permission)
        end
    end)
end)

_FlashLand.loadedComponent("rank")