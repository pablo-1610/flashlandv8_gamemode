--[[
  This file is part of FlashLand.
  Created at 11/12/2021 13:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("nationalBank:alterState", function(accountId, deskNpcId)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Banking.getAccount(accountId, function(account)
        print(("Current state is %s"):format(account.state))
        local newState = account.state == 0 and true or false
        print(("New state should be %s"):format(newState))
        if (not (account)) then
            player:serverResponded()
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.ERROR_OCCUR)
            return
        end
        if (account.state == newState) then
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
            _FlashServer_Banking.setAccountState(accountId, newState, function()
                _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
                    _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Hows_It_Going", "Speech_Params_Force")
                    --_FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (newState and _Static_GenericMessages.BANKING_ACCOUNT_UNLOCKED or _Static_GenericMessages.BANKING_ACCOUNT_LOCKED), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                    _FlashLand.toClient("nationalBank:cbAccounts", _src, accounts)
                    player:serverResponded()
                end)
            end)
        end
    end)
end)