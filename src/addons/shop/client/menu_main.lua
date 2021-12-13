--[[
  This file is part of FlashLand.
  Created at 12/12/2021 13:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Shop.drawer[1] = function(player, categories)
    RageUI.Separator(("Total: %s"):format(_FlashUtils.math_price(_FlashClient_Shop.calculateTotalPrice())))
    --RageUI.Separator(("Points de fidelité: ~y~%i"):format(_FlashClient_Shop.var.points))
    RageUI.Line()
    for categoryId, v in pairs(_FlashClient_Shop.var.categories) do
        RageUI.Button(v.label, nil, { RightLabel = "→" }, true, {
            onActive = function()
                _FlashClient_Shop.var.selectedCategory = categoryId
            end
        }, _FlashClient_Shop.getMenus()[2])
    end

    if (_FlashClient_Shop.isAnyItemInBasket()) then
        RageUI.Line()
        RageUI.Button("Vider mon panier", nil, {}, true, {
            onSelected = function()
                _FlashClient_Shop.var.basket = {}
            end
        })
        RageUI.Button("Valider et payer", nil, { RightLabel = "~g~Facture ~s~→" }, true, {
            onSelected = function()
                _FlashClient_Billing.currentBillingParentMenu = _FlashClient_Shop.getMenus()[1]
                local elements = {}
                for itemId, count in pairs(_FlashClient_Shop.var.basket) do
                    table.insert(elements, { ("Achat de %s x%s"):format(_FlashClient_Shop.getItemLabel(itemId), count), (_FlashClient_Shop.getItemPrice(itemId) * count) })
                end
                _FlashClient_Billing.submitBillingFromMenu(
                        "shop_pay",
                        "LTD Co Limited",
                        elements,
                        { _FlashEnum_BILLINGPAYMENTMETHOD.CARD, _FlashEnum_BILLINGPAYMENTMETHOD.CASH },
                        { basket = _FlashClient_Shop.var.basket, shopId = _FlashClient_Shop.var.shopId, shopNpcId = _FlashClient_Shop.var.shopNpcId },
                        _FlashClient_Shop.getMenus()[1],
                        function()
                            _FlashClient_Shop.var = {
                                basket = {},
                                categories = categories,
                                selectedCategory = nil,
                                points = points
                            }
                        end
                )
            end
        })
    end
end