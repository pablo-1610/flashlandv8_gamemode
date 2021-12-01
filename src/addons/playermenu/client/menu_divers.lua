--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local radar = true
local cinematicMode = false

local function startCinematicMode()
    CreateThread(function()
        while (cinematicMode) do
            DrawRect(0.0, 0.0, 2.0, 0.15, 0,0,0,255)
            DrawRect(0.0, 1.0, 2.0, 0.15, 0,0,0,255)
            Wait(0)
        end
    end)
end

local function alterRadarActive(newState)
    if (not (cinematicMode)) then
        radar = newState
        DisplayRadar(radar)
    end
end

local function alterCinematicMode(newState)
    cinematicMode = newState
    radar = not (newState)
    DisplayRadar(not (newState))
    if (newState) then
        startCinematicMode()
    end
end

_FlashClient_PlayerMenu.drawer[7] = function()
    RageUI.Checkbox("Radar", nil, radar, {}, {
        onChecked = function()
            alterRadarActive(true)
        end,

        onUnChecked = function()
            alterRadarActive(false)
        end
    })


    RageUI.Checkbox("Cinématique", nil, cinematicMode, {}, {
        onChecked = function()
            alterCinematicMode(true)
        end,

        onUnChecked = function()
            alterCinematicMode(false)
        end
    })

    RageUI.Button("Sauvegarder", nil, {}, true, {
        onSelected = function()
            _FlashLand.setIsWaitingForServer(true)
            _FlashLand.toServer("player:requestSave")
        end
    })
end