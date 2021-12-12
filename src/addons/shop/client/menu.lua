--[[
  This file is part of FlashLand.
  Created at 12/12/2021 13:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local menuOpened = false

local menus = {}

_FlashClient_Shop.drawer = {}
_FlashClient_Shop.panelDrawer = {}

_FlashClient_Shop.setMenus = function(currentMenus)
    menus = currentMenus
end

_FlashClient_Shop.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("shop:openMenu", function(shopId, shopType, shopNpcId, categories, points)
    _FlashClient_Shop.var = {
        basket = {},
        categories = categories,
        selectedCategory = nil,
        points = points
    }
    local shopTypeData = _FlashEnum_SHOPTYPEDATA[shopType]
    local title, desc = "", "Achetez ce qui vous plaît"
    local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", shopTypeData.banner)
    local menu_category = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", shopTypeData.banner)
    _FlashClient_Utils.menu_setOnClose(menu_main, function()
        menuOpened = false
    end)
    _FlashClient_Shop.setMenus({ menu_main, menu_category })
    _FlashClient_Menu.tryOpenMenu(function()
        FreezeEntityPosition(PlayerPedId(), true)
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Shop.drawer[id](_FlashClient_Cache.getPlayer(), categories)
                        if (_FlashClient_Shop.isAnyItemInBasket()) then
                            RageUI.Line()
                            RageUI.Button("Vider mon panier", nil, {}, true, {
                                onSelected = function()
                                    _FlashClient_Shop.var.basket = {}
                                end
                            })
                            RageUI.Button(("Total: %s"):format(_FlashUtils.math_price(_FlashClient_Shop.calculateTotalPrice())), nil, { RightLabel = "~b~Payer ~s~→" }, true, {
                                onSelected = function()
                                    local elements = {}
                                    for itemId, count in pairs(_FlashClient_Shop.var.basket) do
                                        table.insert(elements, { ("Achat de %s x%s"):format(_FlashClient_Shop.getItemLabel(itemId), count), (_FlashClient_Shop.getItemPrice(itemId) * count) })
                                    end
                                    _FlashClient_Billing.submitBillingFromMenu(
                                            "shop_pay",
                                            "LTD Co Limited",
                                            elements,
                                            { _FlashEnum_BILLINGPAYMENTMETHOD.CARD, _FlashEnum_BILLINGPAYMENTMETHOD.CASH },
                                            { basket = _FlashClient_Shop.var.basket, shopId = shopId, shopNpcId = shopNpcId },
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
                    end, function()
                        if (_FlashClient_Shop.panelDrawer[id] ~= nil) then
                            _FlashClient_Shop.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)