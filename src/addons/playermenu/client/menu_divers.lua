--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local filterList = { _FlashEnum_DIVERFILTER.NORMAL, _FlashEnum_DIVERFILTER.ORANGE, _FlashEnum_DIVERFILTER.AMPLIFIE, _FlashEnum_DIVERFILTER.BLACK_AND_WHITE }
local filterIndex = 1
local radar = true
local cinematicMode = false

local function startCinematicMode()
    CreateThread(function()
        while (cinematicMode) do
            DrawRect(0.0, 0.0, 2.0, 0.15, 0, 0, 0, 255)
            DrawRect(0.0, 1.0, 2.0, 0.15, 0, 0, 0, 255)
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

    RageUI.List("Filtre : ", filterList, filterIndex, nil, {}, true, {
        onListChange = function(Index)
            filterIndex = Index
        end,
        onSelected = function()
            if filterIndex == 1 then
                SetTimecycleModifier("")
            elseif filterIndex == 2 then
                SetTimecycleModifier("tunnel")
            elseif filterIndex == 3 then
                SetTimecycleModifier("rply_saturation")
            elseif filterIndex == 4 then
                SetTimecycleModifier("rply_saturation_neg")
            elseif filterIndex == 5 then
                SetTimecycleModifier("V_FIB_IT3")
            end
        end,
    })
    -- TODO -> Mettre en place le mode steamer (cacher les informations importantes style code du compte bancaire pour eviter que tous le monde le vois)

    RageUI.Button("Sauvegarder", nil, {}, true, {
        onSelected = function()
            _FlashLand.setIsWaitingForServer(true)
            _FlashLand.toServer("player:requestSave")
        end
    })
end