--[[
  This file is part of FlashLand.
  Created at 06/02/2022 12:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local title, desc = "Action", "Gérer votre organisation"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_grades = RageUI.CreateSubMenu(menu_main, title, desc)
local menu_grades_selected = RageUI.CreateSubMenu(menu_grades, title, desc)
local menu_create_grade = RageUI.CreateSubMenu(menu_grades, title, desc)
local menu_member_list = RageUI.CreateSubMenu(menu_main, title, desc)
local menu_member_manage = RageUI.CreateSubMenu(menu_member_list, title, desc)

local menus = {
    menu_main, --1
    menu_grades, --2
    menu_grades_selected, --3
    menu_create_grade, --4
    menu_member_list, --5
    menu_member_manage, --5
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Organisation_Boss = {}

_FlashClient_Organisation_Boss.drawer = {}
_FlashClient_Organisation_Boss.panelDrawer = {}
_FlashClient_Organisation_Boss.intraVars = {
    name = nil,
    label = nil,
    grades = nil,
    gradesSelected = nil,
    members = nil,
    memberSelected = nil,
}

_FlashClient_Organisation_Boss.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("organisation:openBossMenu", function(name, label, grades, members)
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
        _FlashClient_Organisation_Boss.intraVars.name = name
        _FlashClient_Organisation_Boss.intraVars.label = label
        _FlashClient_Organisation_Boss.intraVars.grades = grades
        _FlashClient_Organisation_Boss.intraVars.members = members
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                local closestPlayer, closestDistance = _FlashClient_Utils.proximity_getClosestPlayer()
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Organisation_Boss.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_Organisation_Boss.panelDrawer[id] ~= nil) then
                            _FlashClient_Organisation_Boss.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)

_FlashLand.onReceive("orga:updateGrade", function(grades)
    _FlashClient_Organisation_Boss.intraVars.grades = grades
end)

_FlashLand.onReceive("orga:updateMembers", function(members)
    _FlashClient_Organisation_Boss.intraVars.members = members
end)