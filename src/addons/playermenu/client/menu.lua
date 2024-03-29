--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
local title, desc, adminDesc = "MON PERSONNAGE", "Menu personnel", "Gestion de FlashLand"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_inventory = RageUI.CreateSubMenu(menu_main, "INVENTAIRE", desc, nil, nil, "root_cause", "black_red")
local menu_equipment = RageUI.CreateSubMenu(menu_main, "ÉQUIPEMENT", desc, nil, nil, "root_cause", "black_red")
local menu_inventory_item = RageUI.CreateSubMenu(menu_inventory, "INVENTAIRE", desc, nil, nil, "root_cause", "black_red")
local menu_portefeuille = RageUI.CreateSubMenu(menu_main, "PORTEFEUILLE", desc, nil, nil, "root_cause", "black_red")
local menu_animations = RageUI.CreateSubMenu(menu_main, "ANIMATIONS", desc, nil, nil, "root_cause", "black_red")
local menu_divers = RageUI.CreateSubMenu(menu_main, "DIVERS", desc, nil, nil, "root_cause", "black_red")
local menu_vehicle = RageUI.CreateSubMenu(menu_main, "VÉHICULE", desc, nil, nil, "root_cause", "black_red")
local menu_admin = RageUI.CreateSubMenu(menu_main, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_players = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_self = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_vehicles = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_reports = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_reports_action = RageUI.CreateSubMenu(menu_admin_reports, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_players_action = RageUI.CreateSubMenu(menu_admin_players, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_players_inventory = RageUI.CreateSubMenu(menu_admin_players_action, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_give_item = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_give_weapon = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_bans = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_bans_action = RageUI.CreateSubMenu(menu_admin_bans, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_organisations = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_organisations_action = RageUI.CreateSubMenu(menu_admin_organisations, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_organisations_action_grades = RageUI.CreateSubMenu(menu_admin_organisations_action, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_organisations_action_grade_selected = RageUI.CreateSubMenu(menu_admin_organisations_action_grades, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_manage_permission = RageUI.CreateSubMenu(menu_admin, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_manage_permission_selected = RageUI.CreateSubMenu(menu_admin_manage_permission, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_manage_permission_create = RageUI.CreateSubMenu(menu_admin_manage_permission, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")
local menu_admin_organisation_create = RageUI.CreateSubMenu(menu_admin_organisations, "ADMINISTRATION", adminDesc, nil, nil, "root_cause", "black_red")

local menus = {
    menu_main, --1
    menu_inventory, --2
    menu_portefeuille, --3
    menu_animations, --4
    menu_admin, --5
    menu_vehicle, --6
    menu_divers, --7
    menu_inventory_item, --8
    menu_admin_players, --9
    menu_admin_self, --10
    menu_admin_vehicles, --11
    menu_equipment, --12
    menu_admin_reports, --13
    menu_admin_reports_action, --14
    menu_admin_players_action, --15
    menu_admin_players_inventory, --16
    menu_admin_give_item, --17
    menu_admin_give_weapon, --18
    menu_admin_bans, --19
    menu_admin_bans_action, --20
    menu_admin_organisations, --21
    menu_admin_organisations_action, --22
    menu_admin_organisations_action_grades, --23
    menu_admin_organisations_action_grade_selected, --24
    menu_admin_manage_permission, --25
    menu_admin_manage_permission_selected, --26
    menu_admin_manage_permission_create, --27
    menu_admin_organisation_create, --28
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_PlayerMenu.drawer = {}
_FlashClient_PlayerMenu.panelDrawer = {}

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
                        _FlashClient_PlayerMenu.drawer[id](_FlashClient_Cache.getPlayer(), {closestPlayer, closestDistance}, _FlashClient_Staff.isCurrentActive())
                    end, function()
                        if (_FlashClient_PlayerMenu.panelDrawer[id] ~= nil) then
                            _FlashClient_PlayerMenu.panelDrawer[id]()
                        end
                    end)
                end
            end
            _FlashClient_Menu.menuClosed()
            -- TODO -> Delete menus
        end)
    end)
end)