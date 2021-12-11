--[[
  This file is part of FlashLand.
  Created at 11/12/2021 15:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("withdraw", function(accountId, amount, deskNpcId)
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
            if (account.balance < amount) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_WITHDRAW_NO_ENOUGH, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            _FlashServer_Banking.withdrawFromAccount(accountId, amount, function()
                player.cash = (player.cash + amount)
                player:saveData()
                player:sendData()
                _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
                    _FlashServer_Npc.get(deskNpcId):sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")
                    --_FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (_Static_GenericMessages.BANKING_DEPOSIT_DONE):format(amount), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                    _FlashLand.toClient("nationalBank:cbAccounts", _src, accounts)
                    player:serverResponded()
                end)
            end)
        end
    end)
end)