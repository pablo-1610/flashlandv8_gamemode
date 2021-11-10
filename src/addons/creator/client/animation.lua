--[[
  This file is part of FlashLand.
  Created at 28/10/2021 15:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

SwitchInPlayer(PlayerPedId())

_FlashLand.onReceiveWithoutNet("creator:playAnimation", function(spawn)
    RenderScriptCams(0,0,0,0,0)
    -- TODO -> Animation when character is done
    local animation = true
    _FlashClient_Utils.memory_loadDict("flashland")
    SwitchOutPlayer(PlayerPedId(), 0, 1)
    _FlashClient_Utils.drawer_spriteWithSmooth(function()
       return (animation)
    end, "flashland", "logo_transparent", 0.5, 0.38, 0.35, 0.60, 0.0)
    _FlashClient_Utils.drawer_textWithSmooth(function()
        return (animation)
    end, 1920/2, (1080/2)+300, "Bienvenue sur ~r~FlashLand", {252, 255, 255}, function()
        while (#(GetEntityCoords(PlayerPedId()) - vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z - 1.0)) >= 1.0) do
            _FlashClient_Utils.ped_tp(PlayerPedId(), vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z - 1.0), spawn.heading)
            Wait(1)
        end
        SwitchInPlayer(PlayerPedId())
        while (#(GetEntityCoords(PlayerPedId()) - vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z - 1.0)) >= 1.0) do
            _FlashClient_Utils.ped_tp(PlayerPedId(), vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z - 1.0), spawn.heading)
            Wait(1)
        end
        Wait(3500)
        _FlashLand.toInternal("spawn:spawned")
        _FlashClient_Utils.screen_radar(true)
        _FlashClient_Utils.loading_hide()
        _FlashLand.setIsWaitingForServer(false)
    end)
    Wait(4500)
    _FlashClient_Utils.loading_show("Chargement du personnage", 5)
    Wait(6000)
    _FlashClient_Utils.loading_show("Synchronisation heure et météo", 5)
    Wait(4000)
    _FlashClient_Synchronizer.destroyTimeOverride()
    _FlashClient_Synchronizer.destroyWeatherOverride()
    Wait(2500)
    _FlashClient_Utils.loading_show("Bienvenue sur FlashLand", 4)
    Wait(3000)
    animation = false
end)
