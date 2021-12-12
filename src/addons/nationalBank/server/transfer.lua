--[[
  This file is part of FlashLand.
  Created at 11/12/2021 16:24
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("nationalBank:transfer", function(acSource, acDest, amount, deskNpcId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    print(acSource)
    print(acDest)
    if (acSource == acDest) then
        player:serverResponded()
        _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_TRANSFER_SAME_ACCOUNT, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
        _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
        return
    end
    _FlashServer_Banking.getAccount(acSource, function(accountSource)
        if (not (accountSource)) then
            player:serverResponded()
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
            return
        end
        -- TODO → Handle job & illegal accounts
        if (accountSource.type == _FlashEnum_BANKACCOUNTTYPE.PERSONAL.id) then
            if (accountSource.owner ~= ("player:%s"):format(player.flashId)) then
                player:serverResponded()
                player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            if (accountSource.balance < amount) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_WITHDRAW_NO_ENOUGH, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            _FlashServer_Banking.getAccount(acDest, function(accountDestination)
                if (not (accountDestination)) then
                    player:serverResponded()
                    _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_TRANSFER_TARGETED_ACCOUNT_NOT_FOUND, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                    _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                    return
                end
                _FlashServer_Banking.depositToAccount(acDest, amount, function()
                    _FlashServer_Banking.withdrawFromAccount(acSource, amount, function()
                        _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, (_Static_GenericMessages.BANKING_TRANSFER_DONE):format(amount, acDest), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                        _FlashServer_Npc.get(deskNpcId):sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")
                        _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
                            _FlashLand.toClient("nationalBank:cbAccounts", _src, accounts)
                            player:serverResponded()
                        end)
                    end)
                end)
            end)
        end
    end)
end)