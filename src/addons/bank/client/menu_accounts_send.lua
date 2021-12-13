--[[
  This file is part of FlashLand.
  Created at 11/12/2021 16:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Bank.drawer[3] = function()
    ---@type _BankAccount
    local account = _FlashClient_Bank.var.accounts[_FlashClient_Bank.var.selectedAccount]
    local accounts = _FlashClient_Bank.var.accounts
    RageUI.Separator("Choisissez un compte")
    ---@param bankAccount _BankAccount
    for _, bankAccount in pairs(accounts) do
        if (bankAccount.accountId == account.accountId) then
            goto continue
        end
        RageUI.Button(("~s~[~o~#%s~s~] %s%s~s~%s"):format(bankAccount.accountId, bankAccount.state == _FlashEnum_BANKACCOUNTSTATE.SUSPENDED and "~c~" or "~s~", bankAccount.label, (showPins and (" (~r~%s~s~)"):format(bankAccount.pin) or "")), ("Type: %s"):format(_FlashEnum_BANKACCOUNTTYPELABEL[bankAccount.type]), { RightLabel = _FlashUtils.math_price(bankAccount.balance) }, true, {
            onSelected = function()
                local amount = _FlashClient_Utils.input_showBox("Montant:", "", 20, true)
                if (amount ~= nil and tonumber(amount) ~= nil) then
                    amount = tonumber(amount)
                    isWaitingForServer = true
                    _FlashLand.toServer("nationalBank:transfer", account.accountId, bankAccount.accountId, amount, _FlashClient_Bank.var.deskNpcId)
                end
            end
        })
        :: continue ::
    end
    RageUI.Button("Compte extérieur", nil, { RightLabel = "→" }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Identifiant du compte:", "", 20, true)
            if (input ~= nil and tonumber(input) ~= nil) then
                input = tonumber(input)
                local amount = _FlashClient_Utils.input_showBox("Montant:", "", 20, true)
                if (amount ~= nil and tonumber(amount) ~= nil) then
                    amount = tonumber(amount)
                    isWaitingForServer = true
                    _FlashLand.toServer("nationalBank:transfer", account.accountId, input, amount, _FlashClient_Bank.var.deskNpcId)
                end
            end
        end
    })
end