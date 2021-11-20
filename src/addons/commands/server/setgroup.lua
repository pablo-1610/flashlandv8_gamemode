--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerConsoleCommand("setgroup", function(args)
    local targetId = tonumber(args[1])
    local rankId = args[2]:lower()
    if (not (targetId)) then
        _FlashLand.errLog("L'id indique est invalide")
        return
    end
    if (not (_FlashServer_Ranks.exists(rankId))) then
        _FlashLand.errLog("Le rang indique n'existe pas")
        return
    end
    if (not (_FlashServer_Players.exists(targetId))) then
        _FlashLand.errLog("Le joueur cible n'est pas connecte")
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(targetId)
    ---@type _Rank
    local rank = _FlashServer_Ranks.get(rankId)
    player:setGroup(rank, true)
    _FlashLand.suc(("Le rang de ^5%s^7 est desormais: ^6%s"):format(GetPlayerName(targetId), rank.label))
    _FlashServer_Staff.updatePlayersForStaff()
end, {"id", "grade"})