--[[
  This file is part of FlashLand.
  Created at 17/11/2021 00:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("staff:onToggle", function(state)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:onToggle sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission(_Config.Staff.permissions["open"]))) then
        player:sendSystemMessage("error", _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        return
    end
    _FlashLand.toClient("staff:cbPlayerList", _src, (state and _FlashServer_Staff.generateAllLightPlayers() or {}))
    _FlashLand.logOverall(("(^4%s^7) %s a désormais son staffmode %s"):format(player.rank.label, GetPlayerName(_src), (state and "^2activé" or "^1désactivé")))
    if (state) then
        _FlashServer_Staff.addActive(_src)
    else
        _FlashServer_Staff.removeFromActives(_src)
    end
    player:serverResponded()
end)