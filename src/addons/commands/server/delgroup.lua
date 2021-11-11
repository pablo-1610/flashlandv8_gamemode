--[[
  This file is part of FlashLand.
  Created at 11/11/2021 01:05
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerConsoleCommand("delgroup", function(args)
    local rankId = args[1]:lower()
    if (not (_FlashServer_Ranks.exists(rankId))) then
        _FlashLand.errLog("Ce rang n'existe pas")
        return
    end
    ---@type _Rank
    local rank = _FlashServer_Ranks.get(rankId)
    _FlashServer_Ranks.delete(rankId)
    _FlashLand.suc(("Le rang ^5%s^7 a bien ete supprime"):format(rank.label))
end, {"id"})