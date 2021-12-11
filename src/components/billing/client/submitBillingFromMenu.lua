--[[
  This file is part of FlashLand.
  Created at 11/12/2021 00:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local menuBillingOpened = false

local function doAcceptPaymentMethod(acceptedPaymentMethods, paymentMethod)
    for k, v in pairs(acceptedPaymentMethods) do
        if v == paymentMethod then
            return (true)
        end
    end
    return (false)
end

local function onBillingMenuClosed(currentMenu, callbackMenu)
    currentMenu.Closed = function()
        menuBillingOpened = false
        callbackMenu.Closable = false
        SetTimeout(100, function()
            callbackMenu.Closable = true
        end)
    end
end

_FlashClient_Billing.submitBillingFromMenu = function(billingTrigger, sender, elements, acceptedPaymentMethods, billingData, callbackMenu, whenBackOnMenu)
    ---@type _Player
    local player = _FlashClient_Cache.getPlayer()
    local total = 0
    for k, v in pairs(elements) do
        total = total + v[2]

    end
    local menu_bill_main = RageUI.CreateSubMenu(callbackMenu, "", "Règlement d'une facture", nil, nil, "root_cause", "shopui_title_fleecabank")
    local menu_bill_selectedMethod = RageUI.CreateSubMenu(menu_bill_main, "", "Sélectionnez le moyen de paiement", nil, nil, "root_cause", "shopui_title_fleecabank")
    local menu_bill_flashPay = RageUI.CreateSubMenu(menu_bill_selectedMethod, "", "Paiement par FlashPay™", nil, nil, "root_cause", "shopui_title_fleecabank")

    local accounts = nil
    menuBillingOpened = true
    menu_bill_selectedMethod.Closable = true
    _FlashClient_Billing.currentBillingPaid = false
    _FlashLand.toServer("banking:requestAccountsForBilling")
    _FlashLand.onReceive("billing:callBackAccounts", function(newAccounts)
        accounts = newAccounts
    end)
    onBillingMenuClosed(menu_bill_main, callbackMenu)
    -- Menu related
    RageUI.Visible(menu_bill_main, true)
    CreateThread(function()
        while (menuBillingOpened) do
            Wait(0)
            RageUI.IsVisible(menu_bill_main, function()
                RageUI.Button(("Émise par: ~o~%s"):format(sender), nil, {}, true, {})
                RageUI.Separator("Récapitulatif de la facture")
                RageUI.Line()
                for _, element in pairs(elements) do
                    RageUI.Button(("~s~%s"):format(element[1]), nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = _FlashUtils.math_price(element[2]) }, true, {})
                end
                RageUI.Line()
                RageUI.Button(("Total: %s"):format(_FlashUtils.math_price(total)), nil, { RightLabel = "~b~Régler ~s~→" }, true, {}, menu_bill_selectedMethod)
            end)

            RageUI.IsVisible(menu_bill_selectedMethod, function()
                if (not (_FlashClient_Billing.currentBillingPaid)) then
                    RageUI.Separator(("Total: %s"):format(_FlashUtils.math_price(total)))
                    RageUI.Button("Payer en ~g~liquide", player.cash < total and "Vous n'avez pas assez de liquide sur vous pour payer." or nil, {}, player.cash >= total, {
                        onSelected = function()
                            isWaitingForServer = true
                            _FlashLand.toServer("bill:payBillCash", billingTrigger, total, billingData)
                        end
                    })
                    RageUI.Button("Payer avec ~b~FlashPay™", nil, { RightLabel = "→" }, true, {}, menu_bill_flashPay)
                else
                    menu_bill_selectedMethod.Closable = false
                    RageUI.Separator("~g~Paiement effectué")
                    RageUI.Line()
                    RageUI.Button("Revenir en arrière", nil, { RightLabel = "→" }, true, {
                        onSelected = function()
                            RageUI.Visible(callbackMenu, true)
                            menuBillingOpened = false
                            if (whenBackOnMenu ~= nil) then
                                whenBackOnMenu()
                            end
                        end,
                    })
                end
            end)
        end
    end)
end