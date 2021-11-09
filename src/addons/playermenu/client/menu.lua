--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
local title, desc = "MON PERSONNAGE", "Menu personnel"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_inventory = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")
local menu_portefeuille = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")
local menu_animations = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")
local menus = { menu_main, menu_inventory, menu_portefeuille, menu_animations }

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_PlayerMenu.drawer = {}

_FlashClient_PlayerMenu.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("playerMenu:openMenu", function()
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_PlayerMenu.drawer[id]()
                    end)
                end
            end
            _FlashClient_Menu.menuClosed()
            -- TODO -> Delete menus
        end)
    end)
end)