--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local availableTypes = { _FlashEnum_BANKACCOUNTTYPE.PERSONAL }

for k, v in pairs(availableTypes) do
    availableTypes[k] = ("~b~%s~s~"):format(v.name)
end

_FlashClient_NationalBank.drawer[3] = function()
    RageUI.List("Type:", availableTypes, _FlashClient_NationalBank.var.accountBuilder.type, nil, {}, true, {
        onListChanged = function(index)
            _FlashClient_NationalBank.var.accountBuilder.type = index
        end
    })
    RageUI.Button(("Code secret: ~r~%s"):format(_FlashClient_NationalBank.var.accountBuilder.pin), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Code:", "", 10, true)
            if (input ~= nil and tonumber(input) ~= nil and tonumber(input) > 0) then
                input = tonumber(input)
                _FlashClient_NationalBank.var.accountBuilder.pin = input
            end
        end
    })
    RageUI.Button(("Nom: \"~o~%s~s~\""):format(_FlashClient_NationalBank.var.accountBuilder.label), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'affichage:", "", 30, false)
            if (input ~= nil) then
                _FlashClient_NationalBank.var.accountBuilder.label = input
            end
        end
    })
    RageUI.Line()
    RageUI.Button("Créer le compte bancaire", nil, { RightLabel = ("%s~s~ →"):format(_Static_GenericMessages.BILLING) }, true, {
        onSelected = function()
            _FlashClient_Billing.submitBillingFromMenu("create_bank_account",
                    _FlashEnum_BILLINGSTATICSENDER.NATIONALBANK,
                    {
                        { "Création d'un compte bancaire", _FlashClient_NationalBank.var.accountCreationPrice },
                        { "Frais de dossier", 100 }
                    },
                    { _FlashEnum_BILLINGPAYMENTMETHOD.CASH, _FlashEnum_BILLINGPAYMENTMETHOD.CARD },
                    function()
                    end,
                    { accountInfos = _FlashClient_NationalBank.var.accountBuilder, deskNpcId = _FlashClient_NationalBank.var.deskNpcId },
                    _FlashClient_NationalBank.getMenus()[3],
                    function()
                        _FlashLand.toServer("nationalBank:requestAccounts")
                    end
            )
        end
    })
end