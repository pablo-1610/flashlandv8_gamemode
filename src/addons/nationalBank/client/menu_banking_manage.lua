--[[
  This file is part of FlashLand.
  Created at 11/12/2021 12:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_NationalBank.drawer[4] = function(player)
    local selectedAccount = _FlashClient_NationalBank.var.selectedAccount
    if (not (_FlashClient_NationalBank.var.accounts[selectedAccount])) then
        RageUI.GoBack()
    else
        ---@type _BankAccount
        local account = _FlashClient_NationalBank.var.accounts[selectedAccount]
        RageUI.Separator(("Compte: ~o~#%s ~s~(~c~%s~s~)"):format(account.accountId, account.label))
        RageUI.Line()
        RageUI.Button(("Statut: %s"):format(_FlashEnum_BANKACCOUNTSTATELABEL[account.state]), nil, {}, true, {})
        if (account.state == _FlashEnum_BANKACCOUNTSTATE.ACTIVE) then
            RageUI.Button(("Solde: %s"):format(_FlashUtils.math_price(account.balance)), nil, {}, true, {})
        end
        RageUI.Line()
        RageUI.Button("~y~Virer ~s~de l'argent", nil, { RightLabel = "→" }, account.state == 1, {}, _FlashClient_NationalBank.getMenus()[5])
        RageUI.Button("~o~Approvisionner ~s~le compte", nil, { RightLabel = "→" }, account.state == 1, {
            onSelected = function()
                local input = _FlashClient_Utils.input_showBox("Montant:", "", 20, true)
                if (input ~= nil and tonumber(input) ~= nil and tonumber(input) > 0) then
                    input = tonumber(input)
                    isWaitingForServer = true
                    _FlashLand.toServer("nationalBank:deposit", account.accountId, input, _FlashClient_NationalBank.var.deskNpcId)
                end
            end
        })
        RageUI.Button("~o~Retirer ~s~du compte", nil, { RightLabel = "→" }, account.state == 1, {
            onSelected = function()
                local input = _FlashClient_Utils.input_showBox("Montant:", "", 20, true)
                if (input ~= nil and tonumber(input) ~= nil and tonumber(input) > 0) then
                    input = tonumber(input)
                    isWaitingForServer = true
                    _FlashLand.toServer("nationalBank:withdraw", account.accountId, input, _FlashClient_NationalBank.var.deskNpcId)
                end
            end
        })
        RageUI.Button("~r~Changer ~s~le code secret", nil, {}, true, {
            onSelected = function()
                local oldPin = _FlashClient_Utils.input_showBox("Ancien code secret:", "", 20, true)
                if (oldPin ~= nil and tonumber(oldPin) ~= nil and tonumber(oldPin) > 0) then
                    oldPin = tonumber(oldPin)
                    local newPin = _FlashClient_Utils.input_showBox("Nouveau code secret:", "", 20, true)
                    if (newPin ~= nil and tonumber(newPin) ~= nil and tonumber(newPin) > 0) then
                        newPin = tonumber(newPin)
                        isWaitingForServer = true
                        _FlashLand.toServer("nationalBank:changePin", account.accountId, oldPin, newPin, _FlashClient_NationalBank.var.deskNpcId)
                    end
                end
            end
        })
        RageUI.Button(account.state == 1 and "~r~Vérouiller~s~ le compte" or "~g~Déverouiller ~s~le compte", nil, account.state == _FlashEnum_BANKACCOUNTSTATE.ACTIVE and { RightBadge = RageUI.BadgeStyle.Alert } or {}, true, {
            onSelected = function()
                isWaitingForServer = true
                _FlashLand.toServer("nationalBank:alterState", account.accountId, _FlashClient_NationalBank.var.deskNpcId)
            end
        })
        RageUI.Button("~r~Supprimer~s~ le compte", nil, { RightBadge = RageUI.BadgeStyle.Alert }, true, {
            onSelected = function()
                isWaitingForServer = true
                _FlashLand.toServer("nationalBank:deleteAccount", account.accountId, _FlashClient_NationalBank.var.deskNpcId)
            end
        })
    end
end