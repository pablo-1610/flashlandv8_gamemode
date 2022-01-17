--[[
  This file is part of FlashLand.
  Created at 17/01/2022 18:25
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local organisationData = {
    name = nil,
    label = nil,
    bossPos = nil,
    safePos = nil,
    spawnVehiclePos = nil,
    delVehiclePos = nil,
    blip = {
        pos = nil,
        id = nil,
        color = nil,
        name = nil,
    },
    grade = {},
}

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

local function allInformationsDefine()
    return (organisationData.name ~= nil and organisationData.label ~= nil and organisationData.bossPos ~= nil and organisationData.safePos ~= nil and organisationData.spawnVehiclePos ~= nil and organisationData.delVehiclePos ~= nil and organisationData.blip.pos ~= nil and organisationData.blip.id ~= nil and organisationData.blip.color ~= nil and organisationData.blip.name ~= nil)
end

local function text(value)
    return (value ~= nil)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[28] = function(player)
    local perm = nil
    RageUI.Separator("~g~Création d'une organisation")
    RageUI.Line()
    perm = "admin.createOrganisation"
    RageUI.Separator("~o~↓↓ ~r~INFORMATION ~o~↓↓")
    RageUI.Button(("%sNom d'attribution"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.name)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'attribution:", nil, 55, false)
            if (input ~= nil) then
                organisationData.name = input
            end
        end,
    })
    RageUI.Button(("%sNom d'affichage"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.label)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'affichage:", nil, 55, false)
            if (input ~= nil) then
                organisationData.label = input
            end
        end,
    })
    RageUI.Separator("~o~↓↓ ~r~POSITION ~o~↓↓")
    RageUI.Button(("%sPos de l'action organisation"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.bossPos)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local playerPos = GetEntityCoords(PlayerPedId())
            organisationData.bossPos = playerPos
        end,
    })
    RageUI.Button(("%sPos du coffre"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.safePos)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local playerPos = GetEntityCoords(PlayerPedId())
            organisationData.safePos = playerPos
        end,
    })
    RageUI.Button(("%sPos du menu + spawn garage"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.spawnVehiclePos)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local playerPos = GetEntityCoords(PlayerPedId())
            organisationData.spawnVehiclePos = playerPos
        end,
    })
    RageUI.Button(("%sPos du rangement véhicule"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.delVehiclePos)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local playerPos = GetEntityCoords(PlayerPedId())
            organisationData.delVehiclePos = playerPos
        end,
    })
    RageUI.Separator("~o~↓↓ ~r~BLIP ~o~↓↓")
    RageUI.Button(("%sPos du blip"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.blip.pos)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local playerPos = GetEntityCoords(PlayerPedId())
            organisationData.blip.pos = playerPos
        end,
    })
    RageUI.Button(("%sId du blip"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.blip.id)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Id du blip:", nil, 55, true)
            local blipId = tonumber(input)
            if (blipId ~= nil) then
                organisationData.blip.id = blipId
            end
        end,
    })
    RageUI.Button(("%sCouleur du blip"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.blip.color)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Couleur du blip:", nil, 55, true)
            local blipColor = tonumber(input)
            if (blipColor ~= nil) then
                organisationData.blip.color = blipColor
            end
        end,
    })
    RageUI.Button(("%sNom du blip"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(organisationData.blip.name)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom du blip:", nil, 55, false)
            if (input ~= nil) then
                organisationData.blip.name = input
            end
        end,
    })
    RageUI.Separator("~o~↓↓ ~r~GRADE ~o~↓↓")

    RageUI.Separator("~o~↓↓ ~r~FINAL ~o~↓↓")
    if (not allInformationsDefine()) then
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 255, 0, 0 } } }, false, {})
    else
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 0, 255, 0 } } }, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:createNewOrganisation", organisationData)
                organisationData = {
                    name = nil,
                    label = nil,
                    bossPos = nil,
                    safePos = nil,
                    spawnVehiclePos = nil,
                    delVehiclePos = nil,
                    blip = {
                        pos = nil,
                        id = nil,
                        color = nil,
                        name = nil,
                    },
                    grade = {},
                }
            end,
        })
    end
end