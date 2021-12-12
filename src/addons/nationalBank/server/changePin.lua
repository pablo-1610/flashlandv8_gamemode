--[[
  This file is part of FlashLand.
  Created at 12/12/2021 17:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("nationalBank:changePin", function(accountId, oldPin, newPin, deskNpcId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Banking.getAccount(accountId, function(account)
        if (not (account)) then
            player:serverResponded()
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
            return
        end
        -- TODO → Handle job & illegal accounts
        if (account.type == _FlashEnum_BANKACCOUNTTYPE.PERSONAL.id) then
            if (account.owner ~= ("player:%s"):format(player.flashId)) then
                player:serverResponded()
                player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            -- TODO → Compare old pin and new pin and check if they are the same
        end
    end)
end)