--[[
  This file is part of FlashLand.
  Created at 30/01/2022 19:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local title, desc = "GARAGE", "Choisissez votre véhicule"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")

local menus = {
    menu_main, --1
}

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Job_VehicleMenu = {}

_FlashClient_Job_VehicleMenu.drawer = {}
_FlashClient_Job_VehicleMenu.panelDrawer = {}
_FlashClient_Job_VehicleMenu.intraVars = {
    jobId = nil,
    zoneId = nil,
    selectedOutPossibility = 1,
    outPossibilities = {},
    outPossibilitiesItems = {}
}

_FlashClient_Job_VehicleMenu.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("job:openVehicleMenu", function(jobId, vehicles, outPossibilities, zoneId)
    _FlashClient_Menu.tryOpenMenu(function()
        _FlashClient_Job_VehicleMenu.intraVars.outPossibilitiesItems = {}
        _FlashClient_Job_VehicleMenu.intraVars.zoneId = zoneId
        _FlashClient_Job_VehicleMenu.intraVars.jobId = jobId
        _FlashClient_Job_VehicleMenu.intraVars.outPossibilities = outPossibilities
        for k, _ in pairs(outPossibilities) do
            _FlashClient_Job_VehicleMenu.intraVars.outPossibilitiesItems[k] = ("Emplacement n°%i"):format(k)
        end
        menuOpened = true
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                local closestPlayer, closestDistance = _FlashClient_Utils.proximity_getClosestPlayer()
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Job_VehicleMenu.drawer[id](_FlashClient_Cache.getPlayer(), vehicles)
                    end, function()
                        if (_FlashClient_Job_VehicleMenu.panelDrawer[id] ~= nil) then
                            _FlashClient_Job_VehicleMenu.panelDrawer[id]()
                        end
                    end)
                end
            end
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)