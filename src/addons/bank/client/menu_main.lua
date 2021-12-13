--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local showpins = false

_FlashClient_Bank.drawer[1] = function(player)
    local accounts = _FlashClient_Bank.var.accounts
    if (#accounts > 0) then
        RageUI.Checkbox("Montrer les codes secret", nil, showPins, {}, {
            onChecked = function()
                showPins = true
            end,
            onUnChecked = function()
                showPins = false
            end
        })
        RageUI.Line()
        ---@param bankAccount _BankAccount
        for selectedAccount, bankAccount in pairs(accounts) do
            RageUI.Button(("~s~[~o~#%s~s~] %s%s~s~%s"):format(bankAccount.accountId, bankAccount.state == _FlashEnum_BANKACCOUNTSTATE.SUSPENDED and "~c~" or "~s~",bankAccount.label, (showPins and (" (~r~%s~s~)"):format(bankAccount.pin) or "")), ("Type: %s"):format(_FlashEnum_BANKACCOUNTTYPELABEL[bankAccount.type]), { RightLabel = ("%s~s~ →"):format(_FlashUtils.math_price(bankAccount.balance)) }, true, {
                onActive = function()
                    _FlashClient_Bank.var.selectedAccount = selectedAccount
                end
            }, _FlashClient_Bank.getMenus()[2])
        end
    end
end