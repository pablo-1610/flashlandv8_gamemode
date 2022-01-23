--[[
  This file is part of FlashLand.
  Created at 15/12/2021 15:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@author Pablo_1610

local title, desc = "", "Prenez les armes !"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "shopui_title_gunclub", "shopui_title_gunclub")
local menu_weapons = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "shopui_title_gunclub", "shopui_title_gunclub")

local menus = {
    menu_main,
    menu_weapons
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Ammunation.drawer = {}
_FlashClient_Ammunation.panelDrawer = {}

_FlashClient_Ammunation.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("ammunation:openMenu", function(deskNpcId, weapons)
    _FlashClient_Ammunation.var = {
        deskNpcId = deskNpcId,
        selectedWeapon = nil,
        weapons = weapons
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
                        _FlashClient_Ammunation.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_Ammunation.panelDrawer[id] ~= nil) then
                            _FlashClient_Ammunation.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)
