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

_FlashClient_Shop.stayOpened = function()
    menuOpened = true
end

_FlashLand.onReceive("shop:openMenu", function(shopId, shopType, shopNpcId, categories, points)
    _FlashClient_Shop.var = {
        basket = {},
        categories = categories,
        selectedCategory = nil,
        points = points,
        shopId = shopId,
        shopNpcId = shopNpcId,
    }
    local shopTypeData = _FlashEnum_SHOPTYPEDATA[shopType]
    local title, desc = "", "Achetez ce qui vous plaît"
    local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", shopTypeData.banner)
    local menu_category = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", shopTypeData.banner)
    _FlashClient_Utils.menu_setOnClose(menu_main, function()
        if (not (_FlashClient_Billing.currentBillingParentMenu == menus[1])) then
            menuOpened = false
        end
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
                    end, function()
                        if (_FlashClient_Shop.panelDrawer[id] ~= nil) then
                            _FlashClient_Shop.panelDrawer[id]()
                        end
                    end)
                end
            end
            print("[FlashLand] Shop menu closed")
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)