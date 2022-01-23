--[[
  This file is part of FlashLand.
  Created at 18/12/2021 13:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

PanelIndex = 1

local title, desc = "Coiffeur", "Donnez vous un nouveau style"
local menuOpened = false
-- Menus
local menu_main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
local menu_barber_coiffure = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")
local menu_barber_beard = RageUI.CreateSubMenu(menu_main, title, desc, nil, nil, "root_cause", "black_red")
menu_barber_coiffure.EnableMouse = true
menu_barber_beard.EnableMouse = true
menu_barber_coiffure.onIndexChange = function(Index)
    PanelIndex = Index
end
menu_barber_beard.onIndexChange = function(Index)
    PanelIndex = Index
end

local menus = {
    menu_main,
    menu_barber_coiffure,
    menu_barber_beard
}

local function updatePlayerSkin()
    local playerSkin = _FlashClient_SkinChanger.getCharacter()
    _FlashClient_SkinChanger.applySkin(playerSkin)
end

for _, v in pairs(menus) do
    v.Closed = function()
        updatePlayerSkin()
    end
end

local function joinPlayerBarberChair(pos, heading)
    local camera
    _FlashClient_Utils.ped_tp(PlayerPedId(), pos, heading)
    _FlashClient_Utils.ped_scenario(PlayerPedId(), "WORLD_HUMAN_SEAT_LEDGE")
    local posCam = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.7)
    local posLook = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.70)
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(camera, posCam.x, posCam.y, posCam.z)
    PointCamAtCoord(camera, posLook.x, posLook.y, posLook.z)
    SetCamActive(camera, true)
    SetCamFov(camera, 45.0)
    RenderScriptCams(1, 0, 0, 0, 0)
end

local function quitPlayerBarberChair(pos, heading)
    updatePlayerSkin()
    local newPos = vector3(pos.x, (pos.y + 1), pos.z)
    _FlashClient_Utils.ped_tp(PlayerPedId(), newPos, heading)
    ClearPedTasksImmediately(PlayerPedId())
    RenderScriptCams(0, 0, 0, 0, 0)
end

_FlashClient_Utils.menu_setOnClose(menu_main, function()
    menuOpened = false
end)

_FlashClient_Barber.drawer = {}
_FlashClient_Barber.panelDrawer = {}

_FlashClient_Barber.getMenus = function()
    return (menus)
end

_FlashLand.onReceive("barber:openMenu", function(barberId, barberData, barberInformation)
    _FlashClient_Barber.var = {
        barberId = barberId
    }
    _FlashClient_Menu.tryOpenMenu(function()
        local barberSeat = barberData.seat
        joinPlayerBarberChair(barberSeat.pos, barberSeat.heading)
        FreezeEntityPosition(PlayerPedId(), true)
        menuOpened = true
        RageUI.Visible(menus[1], true)
        CreateThread(function()
            while (menuOpened) do
                Wait(0)
                for id, menu in pairs(menus) do
                    RageUI.IsVisible(menu, function()
                        _FlashClient_Barber.drawer[id](_FlashClient_Cache.getPlayer(), barberInformation)
                    end, function()
                        if (_FlashClient_Barber.panelDrawer[id] ~= nil) then
                            _FlashClient_Barber.panelDrawer[id]()
                        end
                    end)
                end
            end
            quitPlayerBarberChair(barberSeat.pos, barberSeat.heading)
            FreezeEntityPosition(PlayerPedId(), false)
            _FlashLand.toServer("barber:cbPlayerQuitChair", barberId)
            _FlashClient_Menu.menuClosed()
        end)
    end)
end)