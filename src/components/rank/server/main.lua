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

local function getLowestRank()
    ---@param rank _Rank
    ---@type _Rank
    local lowest
    for rankId, rank in pairs(list) do
        if (lowest == nil) then
            lowest = rank
        end
        if (rank.weight > lowest.weight) then
            lowest = rank
        end
    end
    return lowest
end

_FlashServer_Ranks.exists = function(rankId)
    return (list[rankId] ~= nil)
end

_FlashServer_Ranks.add = function(rankId, rank)
    list[rankId] = rank
end

_FlashServer_Ranks.get = function(rankId)
    if (not (_FlashServer_Ranks.exists(rankId))) then
        return nil
    end
    return (list[rankId])
end

_FlashServer_Ranks.getOrLowest = function(rankId)
    return (_FlashServer_Ranks.get(rankId) or getLowestRank())
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT flash_ranks.id,flash_ranks.label,flash_ranks.weight,flash_ranks_permissions.permission FROM flash_ranks LEFT JOIN flash_ranks_permissions ON flash_ranks.id = flash_ranks_permissions.rankId", {}, function(result)
        for row, data in pairs(result) do
            if (_FlashServer_Ranks.exists(data.id)) then
                ---@type _Rank
                local rank = _FlashServer_Ranks.get(data.id)
                rank:addPermission(data.permission)
            else
                ---@type _Rank
                local rank = _Rank(data.id, data.label, data.weight)
                _FlashServer_Ranks.add(data.id, rank)
                _FlashLand.log(("Ajout d'un rang: ^2%s"):format(data.label))
                rank:addPermission(data.permission)
            end
        end
    end)
end)

_FlashLand.loadedComponent("rank")