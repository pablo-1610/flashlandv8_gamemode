--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerConsoleCommand("addgroup", function(args)
    local rankId = args[1]:lower()
    local rankLabel = args[2]
    local rankWeight = tonumber(args[3])
    if (not (rankWeight)) then
        _FlashLand.errLog("Le poids du rang est invalide")
        return
    end
    if (_FlashServer_Ranks.exists(rankId)) then
        _FlashLand.errLog("Un rang portant ce nom existe deja")
        return
    end
    _FlashServer_Ranks.create(rankId, rankLabel, rankWeight)
    _FlashLand.suc(("Le rang ^5%s^7 a bien ete cree"):format(rankLabel))
end, {"id", "label", "poids"})