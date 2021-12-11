--[[
  This file is part of FlashLand.
  Created at 11/11/2021 13:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.proximity_canInteract = function(closestPlayerData)
    return (closestPlayerData[1] ~= nil and closestPlayerData[2] <= 5.0)
end

_FlashClient_Utils.proximity_getClosestPlayerId = function(closestPlayerData)
    return (GetPlayerServerId(closestPlayerData[1]))
end

_FlashClient_Utils.proximity_getClosestVehicle = function()
    local pCoords = GetEntityCoords(PlayerPedId())
    local closestVehicle, closestDistance = nil, 0
    for vehicle in (_FlashClient_Utils.entityiter_vehicles()) do
        local dst = #(GetEntityCoords(vehicle)-pCoords)
        if (dst > 0.0) then
            if (not (closestVehicle)) then
                closestVehicle = vehicle
                closestDistance = dst
            end
            if (dst < closestDistance) then
                closestVehicle = vehicle
                closestDistance = dst
            end
        end
    end
    return closestVehicle, closestDistance
end

_FlashClient_Utils.proximity_getClosestPlayer = function()
    local players = GetActivePlayers()
    local myCoords = GetEntityCoords(PlayerPedId())
    local closestPlayer, closestDistance = nil, 0
    local function setClosest(player, distance)
        closestPlayer, closestDistance =  player, distance
    end
    for _, localSrc in pairs(players) do
        if (GetPlayerPed(localSrc) ~= PlayerPedId()) then
            local playerPed = GetPlayerPed(localSrc)
            local playerDistance = #(myCoords - (GetEntityCoords(GetPlayerPed(localSrc))))
            if (not closestPlayer) then
                setClosest(playerPed, playerDistance)
            else
                if (playerDistance < closestDistance) then
                    setClosest(playerPed, playerDistance)
                end
            end
        end
    end
    return closestPlayer, closestDistance
end