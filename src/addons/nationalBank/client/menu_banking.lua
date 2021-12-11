--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_NationalBank.drawer[2] = function(player)
    RageUI.Button("Créer un compte bancaire", nil, { RightLabel = "→"}, true, {}, _FlashClient_NationalBank.getMenus()[3])
    local accounts = _FlashClient_NationalBank.var.accounts
    if (#accounts > 0) then
        RageUI.Line()
        ---@param bankAccount _BankAccount
        for selectedAccount, bankAccount in pairs(accounts) do
            RageUI.Button(("Compte #~b~%s~s~"):format(bankAccount.accountId), nil, { RightLabel = "→"}, true, {
                onActive = function()
                    _FlashClient_NationalBank.var.selectedAccount = selectedAccount
                end
            })
        end
    end
end