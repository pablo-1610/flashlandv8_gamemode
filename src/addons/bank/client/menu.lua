--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local title, desc = "", "Gérez vos comptes"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "shopui_title_mazebank")
local menu_accounts = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "shopui_title_mazebank")
local menu_accounts_send = RageUI.CreateSubMenu(menu_accounts, title, desc, nil, nil, "root_cause", "shopui_title_mazebank")

local menus = {
    menu_main,
    menu_accounts,
    menu_accounts_send
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Bank.drawer = {}
_FlashClient_Bank.panelDrawer = {}

_FlashClient_Bank.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("bank:openMenu", function(deskNpcId, accounts)
    _FlashClient_Bank.var = {
        deskNpcId = deskNpcId,
        accounts = accounts,
        selectedAccount = nil
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
                        _FlashClient_Bank.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_Bank.panelDrawer[id] ~= nil) then
                            _FlashClient_Bank.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)
