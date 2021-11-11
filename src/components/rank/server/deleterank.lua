--[[
  This file is part of FlashLand.
  Created at 11/11/2021 01:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Ranks.delete = function(id)
    if (not (_FlashServer_Ranks.exists(id))) then
        _FlashLand.err(("Tentative de supprimer un rang inexistant (^3%s^7)"):format(id))
        return
    end
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Ranks.getGroupPlayers(id)) do
        player:setGroupId(_ConfigServer.Start.rank, true)
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, "En raison de la suppression de votre grade, le grade par défaut vous a été attribué")
        -- TODO → Pour le staffmode, update le joueur dans la liste (grade)
    end
    _FlashServer_Database.execute("DELETE FROM flash_ranks WHERE id = @id", { ["id"] = id })
    _FlashServer_Database.execute("DELETE FROM flash_ranks_permissions WHERE rankId = @rankId", { ["rankId"] = id })
    _FlashServer_Ranks.remove(id)
end