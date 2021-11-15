--[[
  This file is part of FlashLand.
  Created at 11/11/2021 01:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

-- FIXME → Les perms ne sont pas refresh correctement ?
_FlashServer_Ranks.refresh = function(id)
    if (not (_FlashServer_Ranks.exists(id))) then
        _FlashLand.err(("Tentative de supprimer un rang inexistant (^3%s^7)"):format(id))
        return
    end
    ---@type _Rank
    local rank = _FlashServer_Ranks.get(id)
    local permissions = {}
    _FlashServer_Database.query("SELECT * FROM flash_ranks_permissions WHERE rankId = @rankId", {
        ["rankId"] = id
    }, function(result)
        for _, row in pairs(result) do
            table.insert(permissions, row.permission)
        end
    end)
    rank.permissions = permissions
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Ranks.getGroupPlayers(id)) do
        player.rank = rank
        player:sendData()
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, "Les permissions de votre grade viennent d'être mises à jour")
    end
end