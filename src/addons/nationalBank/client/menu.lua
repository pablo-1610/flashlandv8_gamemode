--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local title, desc = "", "Banque Nationale"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "shopui_title_mazebank")
local menu_banking = RageUI.CreateSubMenu(menu_main, title, desc,nil, nil, "root_cause", "shopui_title_mazebank")
local menu_banking_manage = RageUI.CreateSubMenu(menu_banking, title, desc, nil, nil, "root_cause", "shopui_title_mazebank")
local menu_banking_manage_send = RageUI.CreateSubMenu(menu_banking_manage, title, desc, nil, nil, "root_cause", "shopui_title_mazebank")
local menu_banking_create = RageUI.CreateSubMenu(menu_banking, title, desc, nil, nil, "root_cause", "shopui_title_mazebank")

local menus = {
    menu_main,
    menu_banking,
    menu_banking_create,
    menu_banking_manage,
    menu_banking_manage_send
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_NationalBank.drawer = {}
_FlashClient_NationalBank.panelDrawer = {}

_FlashClient_NationalBank.requestAccounts = function()
    _FlashLand.toServer("nationalBank:requestAccounts")
end

_FlashClient_NationalBank.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("banking:cbAccounts", function(accounts)
    _FlashClient_NationalBank.var.accounts = accounts
end)

_FlashLand.onReceive("nationalBank:openMenu", function(deskNpcId, accountCreationPrice, accounts)
    _FlashClient_NationalBank.var.deskNpcId = deskNpcId
    _FlashClient_NationalBank.var.accountCreationPrice = accountCreationPrice
    _FlashClient_NationalBank.var.accounts = accounts
    _FlashClient_NationalBank.var.accountBuilder = {
        pin = 12345,
        label = "FNB",
        type = _FlashEnum_BANKACCOUNTTYPE.PERSONAL.id
    }
    _FlashClient_Menu.tryOpenMenu(function()
        FreezeEntityPosition(PlayerPedId(), true)
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_NationalBank.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_NationalBank.panelDrawer[id] ~= nil) then
                            _FlashClient_NationalBank.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)
