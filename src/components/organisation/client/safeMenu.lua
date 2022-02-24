--[[
  This file is part of FlashLand.
  Created at 19/02/2022 12:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local title, desc = "Action", "Gérer votre organisation"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_items = RageUI.CreateSubMenu(menu_main, title, desc)
local menu_weapons = RageUI.CreateSubMenu(menu_main, title, desc)
local safeMenu_items_recover = RageUI.CreateSubMenu(menu_items, title, desc)
local safeMenu_items_deposit = RageUI.CreateSubMenu(menu_items, title, desc)
local safeMenu_weapons_recover = RageUI.CreateSubMenu(menu_weapons, title, desc)
local safeMenu_weapons_deposit = RageUI.CreateSubMenu(menu_weapons, title, desc)

local menus = {
    menu_main, --1
    menu_items, --2
    menu_weapons, --3
    safeMenu_items_recover, --4
    safeMenu_items_deposit, --5
    safeMenu_weapons_recover, --6
    safeMenu_weapons_deposit --7
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Organisation_Safe = {}

_FlashClient_Organisation_Safe.drawer = {}
_FlashClient_Organisation_Safe.panelDrawer = {}
_FlashClient_Organisation_Safe.intraVars = {
    name = nil,
    label = nil,
    items = nil,
    weapons = nil,
}

_FlashClient_Organisation_Safe.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("organisation:openSafeMenu", function(name, label, items, weapons)
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
        _FlashClient_Organisation_Safe.intraVars.name = name
        _FlashClient_Organisation_Safe.intraVars.label = label
        _FlashClient_Organisation_Safe.intraVars.items = items
        _FlashClient_Organisation_Safe.intraVars.weapons = weapons
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                local closestPlayer, closestDistance = _FlashClient_Utils.proximity_getClosestPlayer()
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Organisation_Safe.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_Organisation_Safe.panelDrawer[id] ~= nil) then
                            _FlashClient_Organisation_Safe.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)

_FlashLand.onReceive("orga:updateItems", function(items)
    _FlashClient_Organisation_Safe.intraVars.items = items
end)

_FlashLand.onReceive("orga:updateWeapons", function(weapons)
    _FlashClient_Organisation_Safe.intraVars.weapons = weapons
end)