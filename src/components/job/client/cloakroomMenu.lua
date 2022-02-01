--[[
  This file is part of FlashLand.
  Created at 01/02/2022 20:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local title, desc = "VESTIAIRES", "Choisissez votre tenue"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_clothes = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")

local menus = {
    menu_main, --1
    menu_clothes, --2
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Job_CloakroomMenu = {}

_FlashClient_Job_CloakroomMenu.drawer = {}
_FlashClient_Job_CloakroomMenu.panelDrawer = {}
_FlashClient_Job_CloakroomMenu.intraVars = {
    jobId = nil,
    workClothes = nil,
    additionalClothes = nil
}

_FlashClient_Job_CloakroomMenu.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("job:openCloakroomMenu", function(jobId, workClothes, additionalClothes)
    _FlashClient_Menu.tryOpenMenu(function()
        _FlashClient_Job_CloakroomMenu.intraVars.jobId = jobId
        _FlashClient_Job_CloakroomMenu.intraVars.workClothes = workClothes
        _FlashClient_Job_CloakroomMenu.intraVars.additionalClothes = additionalClothes
        menuOpened = true
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Job_CloakroomMenu.drawer[id](_FlashClient_Cache.getPlayer())
                    end, function()
                        if (_FlashClient_Job_CloakroomMenu.panelDrawer[id] ~= nil) then
                            _FlashClient_Job_CloakroomMenu.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)