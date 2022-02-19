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

local menus = {
    menu_main, --1
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Organisation_Safe = {}

_FlashClient_Organisation_Safe.drawer = {}
_FlashClient_Organisation_Safe.panelDrawer = {}
_FlashClient_Organisation_Safe.intraVars = {

}

_FlashClient_Organisation_Safe.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("organisation:openSafeMenu", function()
    _FlashClient_Menu.tryOpenMenu(function()
        menuOpened = true
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