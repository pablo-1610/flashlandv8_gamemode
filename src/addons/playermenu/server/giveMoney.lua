--[[
  This file is part of FlashLand.
  Created at 11/12/2021 17:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("playerMenu:giveMoney", function(targetSrc, amount)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Players.exists(targetSrc))) then
        _FlashServer_Warden.violation(targetSrc, _FlashEnum_WARDENVIOLATION.TARGET_NO_EXISTS)
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSrc)
    -- Security
    if (not (_FlashServer_Warden.isCloseEnoughToInteract(GetPlayerPed(_src), GetPlayerPed(targetSrc)))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_INTERACTION_TOO_FAR)
        return
    end
    -- No enough money
    if (player.cash < amount) then
        player:serverResponded()
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.NO_ENOUGH_MONEY)
        return
    end
    -- Do transfer between player.money and the other one
    player.cash = (player.cash - amount)
    target.cash = (target.cash + amount)
    player:serverResponded()
    player:saveData()
    target:saveData()
    player:sendData()
    target:sendData()
    _FlashLand.toClient("playerMenu:giveMoneyNotification", targetSrc, _src, player.identity, "Don d'argent", ("~o~%s %s"):format(player.identity.firstname, player.identity.lastname), ("Vous avez reçu %s"):format(_FlashUtils.math_price(amount)))
end)