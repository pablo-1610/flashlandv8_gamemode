--[[
  This file is part of FlashLand.
  Created at 30/01/2022 14:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local title, desc = "MÉTIER", "Menu personnel"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")

local menus = {
    menu_main, --1
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Job_GenericMenu = {}

_FlashClient_Job_GenericMenu.drawer = {}
_FlashClient_Job_GenericMenu.panelDrawer = {}

_FlashClient_Job_GenericMenu.getMenus = function()
    return (menus)
end

function _FlashClient_Job:openDefaultWorkMenu()
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                local closestPlayer, closestDistance = _FlashClient_Utils.proximity_getClosestPlayer()
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Job_GenericMenu.drawer[id](_FlashClient_Cache.getPlayer(), { closestPlayer, closestDistance })
                    end, function()
                        if (_FlashClient_Job_GenericMenu.panelDrawer[id] ~= nil) then
                            _FlashClient_Job_GenericMenu.panelDrawer[id]()
                        end
                    end)
                end
            end
            _FlashClient_Menu.menuClosed()
        end)
    end)
end