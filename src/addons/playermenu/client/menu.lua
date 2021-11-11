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
local menu_inventory = RageUI.CreateSubMenu(menu_main, "INVENTAIRE", desc, nil, nil, "root_cause", "black_red")
local menu_inventory_item = RageUI.CreateSubMenu(menu_inventory, "INVENTAIRE", desc, nil, nil, "root_cause", "black_red")
local menu_portefeuille = RageUI.CreateSubMenu(menu_main, "PORTEFEUILLE", desc, nil, nil, "root_cause", "black_red")
local menu_animations = RageUI.CreateSubMenu(menu_main, "ANIMATIONS", desc, nil, nil, "root_cause", "black_red")
local menu_divers = RageUI.CreateSubMenu(menu_main, "DIVERS", desc, nil, nil, "root_cause", "black_red")
local menu_admin = RageUI.CreateSubMenu(menu_main, "ADMINISTRATION", "Gestion de FlashLand", nil, nil, "root_cause", "black_red")
local menu_vehicle = RageUI.CreateSubMenu(menu_main, "VÉHICULE", desc, nil, nil, "root_cause", "black_red")


local menus = {
    menu_main,
    menu_inventory,
    menu_portefeuille,
    menu_animations,
    menu_admin,
    menu_vehicle,
    menu_divers,
    menu_inventory_item
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_PlayerMenu.drawer = {}

_FlashClient_PlayerMenu.getMenus = function()
    return (menus)
end

_FlashLand.onReceiveWithoutNet("playerMenu:openMenu", function()
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                local closestPlayer, closestDistance = _FlashClient_Utils.proximity_getClosestPlayer()
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_PlayerMenu.drawer[id](_FlashClient_Cache.getPlayer(), {closestPlayer, closestDistance})
                    end)
                end
            end
            _FlashClient_Menu.menuClosed()
            -- TODO -> Delete menus
        end)
    end)
end)