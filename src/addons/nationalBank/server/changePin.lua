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
    if (tonumber(oldPin) == nil or tonumber(newPin) == nil) then
        player:serverResponded()
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
        return
    end
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
            if(account.pin ~= oldPin) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_OLDPIN_WRONG, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            if (account.pin == newPin) then
                player:serverResponded()
                _FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.ERROR, _Static_GenericMessages.BANKING_OLDPIN_SAME_AS_NEWPIN, _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Insult_Med", "Speech_Params_Force")
                return
            end
            _FlashServer_Banking.setPin(accountId, newPin, function()
                print("Ok set pin")
                _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
                    _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Shocked_Med", "Speech_Params_Force_Shouted_Critical")
                    --_FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (_Static_GenericMessages.BANKING_ACCOUNT_DELETED):format(account.accountId), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                    _FlashLand.toClient("banking:cbAccounts", _src, accounts)
                    player:serverResponded()
                end)
            end)
            -- TODO → Compare old pin and new pin and check if they are the same
        end
    end)
end)