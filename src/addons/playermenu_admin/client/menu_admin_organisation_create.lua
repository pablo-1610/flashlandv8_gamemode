--[[
  This file is part of FlashLand.
  Created at 17/01/2022 18:25
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local gradesInfo = {}
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
    grades = {},
}

gradesInfo[1] = {
    gradeName = "boss",
    gradeLabel = "Gérant",
    gradeId = 1,
    permissions = {}
}
for k, permission in pairs(_Config.OrganisationPermission) do
    table.insert(gradesInfo[1].permissions, permission)
end
table.insert(organisationData.grades, gradesInfo[1])

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

local function allInformationsDefine()
    return (organisationData.name ~= nil and organisationData.label ~= nil and organisationData.bossPos ~= nil and organisationData.safePos ~= nil and organisationData.spawnVehiclePos ~= nil and organisationData.delVehiclePos ~= nil and organisationData.blip.pos ~= nil and organisationData.blip.id ~= nil and organisationData.blip.color ~= nil and organisationData.blip.name ~= nil and organisationData.grades ~= nil)
end

local function text(value)
    return (value ~= nil)
end

local function checkGradeExist(id)
    for index, _ in pairs(gradesInfo) do
        if (id == index) then
            return (true)
        end
    end
    return (false)
end

local function returnValue(value)
    if (value ~= nil) then
        return (value)
    else
        return _FlashClient_Utils.menu_label_change()
    end
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
    RageUI.Button("Créer un grade", nil, {}, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Id du grade:", nil, 15, true)
            local grade = tonumber(input)
            if ((grade ~= nil) and (grade > 0) and (not (checkGradeExist(grade)))) then
                gradesInfo[grade] = {}
            end
        end,
    })
    RageUI.Separator("~o~↓↓ ~r~PERSONALISATION GRADE~o~↓↓")
    for index, v in pairs(gradesInfo) do
        if (v.gradeName:lower() == "boss") then
            RageUI.Button(("[~o~%s~s~] Nom : ~b~%s"):format(index, returnValue(v.gradeLabel)), ("~r~Vous ne pouvez modifier le grade boss car c'est le role de base !\nNom d'attribution : ~b~%s~s~~n~Nom d'affichage : ~b~%s~s~~n~Id du grade : ~b~%s~s~"):format(returnValue(v.gradeName), returnValue(v.gradeLabel), index), {}, false, {})
        end
        RageUI.Button(("[~o~%s~s~] Nom : ~b~%s"):format(index, returnValue(v.gradeLabel)), ("Nom d'attribution : ~b~%s~s~~n~Nom d'affichage : ~b~%s~s~~n~Id du grade : ~b~%s~s~"):format(returnValue(v.gradeName), returnValue(v.gradeLabel), index), {}, (checkPerm(perm)), {
            onSelected = function()
                local name = _FlashClient_Utils.input_showBox("Nom d'attribution du grade:", nil, 55, false)
                if (name ~= nil) then
                    local label = _FlashClient_Utils.input_showBox("Nom du grade:", nil, 125, false)
                    if (label ~= nil) then
                        gradesInfo[index] = {
                            gradeName = name,
                            gradeLabel = label,
                            gradeId = index,
                            permissions = {}
                        }
                        for gradeIndex, data in pairs(organisationData.grades) do
                            if (index == data.gradeId) then
                                table.remove(organisationData.grades, gradeIndex)
                            end
                        end
                        table.insert(organisationData.grades, gradesInfo[index])
                    end
                end
            end,
        })
    end
    RageUI.Separator("~o~↓↓ ~r~FINAL ~o~↓↓")
    if (not allInformationsDefine()) then
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 255, 0, 0 } } }, false, {})
    else
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 0, 255, 0 } } }, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:createNewOrganisation", organisationData)
                gradesInfo = {}
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
                    grades = {},
                }
            end,
        })
    end
end