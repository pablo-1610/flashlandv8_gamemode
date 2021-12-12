--[[
  This file is part of FlashLand.
  Created at 11/12/2021 16:43
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerConsoleCommand("givemoney", function(args)
    local targetId = tonumber(args[1])
    local amount = tonumber(args[2])
    if (not (targetId)) then
        _FlashLand.errLog("L'id indique est invalide")
        return
    end
    if (not (amount) or amount <= 0) then
        _FlashLand.errLog("La somme à donner est invalide")
        return
    end
    if (not (_FlashServer_Players.exists(targetId))) then
        _FlashLand.errLog("Le joueur cible n'est pas connecte")
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(targetId)
    player.cash = player.cash + amount
    player:saveData()
    player:sendData()
    _FlashLand.suc(("Le joueur ^5%s^7 a recu: ^1%s$"):format(GetPlayerName(targetId), amount))
    _FlashServer_Staff.updatePlayersForStaff()
end, { "id", "quantite" })