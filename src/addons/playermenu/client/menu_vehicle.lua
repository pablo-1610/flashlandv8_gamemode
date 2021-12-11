--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local speedLimiterActive = false
local speedLimiter = nil

local doorIndexes = {
    "Tout",
    "Toutes les portes",
    "Capot & Coffre",
    "Avant gauche",
    "Avant droite",
    "Arrière gauche",
    "Arrière droite",
    "Capot",
    "Coffre",
}
local doorsRelative = {
    {0,1,2,3,4,5},
    {0,1,2,3},
    {4,5},
    {0},
    {1},
    {2},
    {3},
    {4},
    {5},
}
local doorActions = {
    {
        label = "Ouvrir la porte",
        action = function(selectedDoorIndex, vehicle)
            for _, door in pairs(doorsRelative[selectedDoorIndex]) do
                SetVehicleDoorOpen(vehicle, door, false, false)
            end
        end
    },

    {
        label = "Fermer la porte",
        action = function(selectedDoorIndex, vehicle)
            for _, door in pairs(doorsRelative[selectedDoorIndex]) do
                SetVehicleDoorShut(vehicle, door, false)
            end
        end
    }
}

local currentDoorIndex = 1

_FlashClient_PlayerMenu.drawer[6] = function()
    if (not (_FlashClient_Utils.ped_isDriver(PlayerPedId()))) then
        speedLimiterActive = false
        RageUI.GoBack()
    else
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        RageUI.Checkbox(("Moteur (~o~%s%%~s~):"):format(math.floor(GetVehicleEngineHealth(vehicle)*100/1000)), nil, GetIsVehicleEngineRunning(vehicle), {}, {
            onChecked = function()
                SetVehicleEngineOn(vehicle, true, true, true)
            end,

            onUnChecked = function()
                SetVehicleEngineOn(vehicle, false, true, true)
                SetVehicleUndriveable(vehicle, true)
            end
        })
        RageUI.Line()
        RageUI.List("Sélection:", doorIndexes, currentDoorIndex, nil, {}, true, {
            onListChange = function(index)
                currentDoorIndex = index
            end
        })

        for _, action in pairs(doorActions) do
            RageUI.Button(action.label, nil, {}, true, {
                onSelected = function()
                    action.action(currentDoorIndex, vehicle)
                end
            })
        end
        RageUI.Line()
        RageUI.Checkbox("Limitateur", nil, speedLimiterActive, {}, {
            onChecked = function()
                if (speedLimiter == nil) then
                    speedLimiter = 100.0
                end
                speedLimiterActive = true
                SetVehicleMaxSpeed(vehicle, speedLimiter/3.6)
            end,

            onUnChecked = function()
                speedLimiterActive = false
                SetVehicleMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
            end
        })
        if (speedLimiterActive) then
            RageUI.Button(("Limitation: ~r~%s km/h"):format(speedLimiter), nil, { RightLabel = "→" }, true, {
                onSelected = function()
                    local input = _FlashClient_Utils.input_showBox("Entrez la vitesse limite", "", 5, true)
                    if (input ~= nil and tonumber(input) ~= nil and tonumber(input) >= 0) then
                        input = tonumber(input)
                        speedLimiter = input
                        SetVehicleMaxSpeed(vehicle, speedLimiter/3.6)
                    end
                end
            })
        end
    end
end