--[[
  This file is part of FlashLand.
  Created at 14/01/2022 12:50
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local newRole = {
    name = nil,
    label = nil,
    color = nil,
    weight = nil,
    position = nil,
    permissions = {}
}
local colorIndex = 1
local colorList = {}

for i, v in pairs(_Config.Color) do
    table.insert(colorList, ("%s%s~s~"):format(v.color, v.name))
end

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

local function text(value)
    return (value ~= nil)
end

local permissionsList = {}

for _, permission in pairs(_Config.StaffPermission) do
    table.insert(permissionsList, permission)
end

local function getPlayerHasPermission(actualPermissionRank, permissionSelected)
    for _, rankPermission in pairs(actualPermissionRank) do
        if (permissionSelected == rankPermission) then
            return (true)
        end
    end
    return (false)
end

local function allInformationsDefine()
    return (newRole.name ~= nil and newRole.label ~= nil and newRole.color ~= nil)
end

local function getPositionExist(pos)
    for _, data in pairs(_FlashClient_Staff.getRankList()) do
        if (data.position == pos) then
            return (true)
        end
    end
    return (false)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[27] = function(player)
    local perm = nil
    perm = "admin.createGroup"
    RageUI.Button(("%sNom d'attribution"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(newRole.name)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'attribution du group:", nil, 55, false)
            if (input ~= nil) then
                newRole.name = input:lower()
            end
        end,
    })
    RageUI.Button(("%sNom d'affichage"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(newRole.label)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'affichage du group:", nil, 55, false)
            if (input ~= nil) then
                newRole.label = input
            end
        end,
    })
    RageUI.Button(("%sPoids de l'inventaire"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(newRole.weight)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Poids de l'inventaire que la personne aura:", nil, 55, true)
            local newWeight = tonumber(input)
            if ((newWeight > 0) and (newWeight ~= nil)) then
                newRole.weight = newWeight
            end
        end,
    })
    RageUI.Button(("%sPosition du grade"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = (not (text(newRole.position)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, (checkPerm(perm)), {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Position:", nil, 55, true)
            local newPosition = tonumber(input)
            if ((newPosition > 0) and (newPosition ~= nil) and (not (getPositionExist(newPosition)))) then
                newRole.position = newPosition
            else
                _FlashClient_Utils.notifications_show("Cette position est déjà utilisé pour un grade")
            end
        end,
    })
    RageUI.List("Couleur", colorList, colorIndex, nil, {}, (checkPerm(perm)), {
        onListChange = function(Index)
            colorIndex = Index
            newRole.color = colorIndex
        end,
    })
    RageUI.Separator("~b~↓↓ ~s~Permissions ~b~↓↓")
    for i, permission in pairs(permissionsList) do
        RageUI.Checkbox(("Perm : %s"):format(permission.label), ("~y~Information : ~s~%s"):format(permission.description), getPlayerHasPermission(newRole.permissions, permission.perm), {}, {
            onChecked = function()
                table.insert(newRole.permissions, permission.perm)
            end,
            onUnChecked = function()
                for index, permSelected in pairs(newRole.permissions) do
                    if (permSelected == permission.perm) then
                        table.remove(newRole.permissions, index)
                    end
                end
            end
        })
    end
    if (not allInformationsDefine()) then
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 255, 0, 0 } } }, false, {})
    else
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 0, 255, 0 } } }, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:newGradeStaffCreate", newRole)
                newRole = {
                    name = nil,
                    label = nil,
                    color = nil,
                    permissions = {}
                }
            end,
        })
    end
end