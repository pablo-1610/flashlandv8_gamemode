--[[
  This file is part of FlashLand.
  Created at 11/12/2021 13:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("nationalBank:deleteAccount", function(accountId, deskNpcId)
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
            _FlashServer_Banking.deleteAccount(accountId, function()
                _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
                    _FlashServer_Npc.get(deskNpcId):sayForAll("Generic_Shocked_Med", "Speech_Params_Force_Shouted_Critical")
                    --_FlashLand.toClient("utils:notifications_showAdvanced", _src, _FlashEnum_NOTIFICATIONSTATICSENDER.NATIONALBANK, _Static_GenericMessages.SUCCESS, (_Static_GenericMessages.BANKING_ACCOUNT_DELETED):format(account.accountId), _FlashEnum_CHARACTERPICTURE.FLEECA, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
                    _FlashLand.toClient("banking:cbAccounts", _src, accounts)
                    player:serverResponded()
                end)
                _FlashServer_Webhooks.send(_FlashServer_Webhooks.send(_Webhooks.BANK_DELETE, ("[%s] __%s__ (%s) a supprimé un compte (`#%s`)"):format(player.rank.label, player.name, player.flashId, accountId)))
            end)
        end
    end)
end)