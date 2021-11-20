--[[
  This file is part of FlashLand.
  Created at 20/11/2021 14:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local spawnTypes = { _FlashEnum_VEHSPAWNTYPE.SPAWN_AND_TELEPORT, _FlashEnum_VEHSPAWNTYPE.JUST_SPAWN }
local spawnIndex = 1

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[11] = function(player)
    local perm = nil
    local closestVehicle, closestDistance = _FlashClient_Utils.proximity_getClosestVehicle()

    local function canInteractWithClosestVehicle()
        return (closestVehicle ~= nil and closestDistance <= 100.0)
    end

    local function drawClosestVehicleIndicator(vehicle)
        local vehCoords = GetEntityCoords(vehicle)
        DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z + 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
    end

    RageUI.Separator(("Rang: %s%s"):format(player.rank.baseColor, player.rank.label))
    RageUI.Line()
    RageUI.List(("%sSpawn un véhicule"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm("admin.vehspawn")))), spawnTypes, spawnIndex, nil, {}, checkPerm("admin.vehspawn"), {
        onListChange = function(index)
            spawnIndex = index
        end,
        onSelected = function()
            if (not (checkPerm("admin.vehspawn"))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
                return
            end
            local input = _FlashClient_Utils.input_showBox("Modèle", "", 20, false)
            if (input ~= nil) then
                input = input:lower()
                local model = GetHashKey(input)
                if (not (IsModelValid(model))) then
                    _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.INVALID_MODEL)
                else
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("admin:spawnVehicle", model, (spawnTypes[spawnIndex] == _FlashEnum_VEHSPAWNTYPE.SPAWN_AND_TELEPORT))
                end
            end
        end
    })

    local myVehicle = nil
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        myVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    end

    perm = "admin.vehdelete"
    RageUI.Button(myVehicle == nil and ("%s%sSupprimer le véhicule proche"):format(_FlashClient_Utils.menu_tooFarIndicatorIfTrue(not (canInteractWithClosestVehicle())), _FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))) or ("%sSupprimer ~y~mon~s~ véhicule"):format(_FlashClient_Staff.permCross(not (checkPerm(perm)))), nil, {}, checkPerm(perm) and (myVehicle ~= nil and true or canInteractWithClosestVehicle()), {
        onActive = function()
            drawClosestVehicleIndicator(myVehicle == nil and closestVehicle or myVehicle)
        end,
        onSelected = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
            else
                if (myVehicle == nil) then
                    if (not (canInteractWithClosestVehicle())) then
                        _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_CLOSEST_VEHICLE)
                    else
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("admin:deleteVehicle", NetworkGetNetworkIdFromEntity(closestVehicle))
                    end
                else
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("admin:deleteVehicle", NetworkGetNetworkIdFromEntity(myVehicle))
                end
            end
        end,
    })

    perm = "admin.vehmax"
    RageUI.Button(myVehicle == nil and ("%s%sMaxer le véhicule proche"):format(_FlashClient_Utils.menu_tooFarIndicatorIfTrue(not (canInteractWithClosestVehicle())), _FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))) or ("%sMaxer ~y~mon~s~ véhicule"):format(_FlashClient_Staff.permCross(not (checkPerm(perm)))), nil, {}, checkPerm(perm) and (myVehicle ~= nil and true or canInteractWithClosestVehicle()), {
        onActive = function()
            drawClosestVehicleIndicator(myVehicle == nil and closestVehicle or myVehicle)
        end,
        onSelected = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
            else
                if (myVehicle == nil) then
                    if (not (canInteractWithClosestVehicle())) then
                        _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_CLOSEST_VEHICLE)
                    else
                        _FlashClient_Utils.vehicle_applyMaxProperties(closestVehicle)
                    end
                else
                    _FlashClient_Utils.vehicle_applyMaxProperties(myVehicle)
                end
            end
        end,
    })
end