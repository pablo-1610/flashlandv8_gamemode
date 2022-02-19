--[[
  This file is part of FlashLand.
  Created at 19/02/2022 12:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local data = {
    name = nil,
    label = nil,
    id = nil,
    permissions = {}
}

local function text(value)
    return (value ~= nil)
end

local function getPositionExist(pos)
    ---@param grade _OrgaGrade
    for _, grade in pairs(_FlashClient_Organisation_Boss.intraVars.grades) do
        if (grade.gradeId == pos) then
            return (true)
        end
    end
    return (false)
end

local function checkGradePerm(perm, permissions)
    for _, permission in pairs(permissions) do
        if (perm == permission) then
            return (true)
        end
    end
    return (false)
end

local function allInformationsDefine()
    return ((data.name ~= nil) and (data.label ~= nil) and (data.id ~= nil))
end

---@param player _Player
_FlashClient_Organisation_Boss.drawer[4] = function(player)
    RageUI.Button("Nom d'attribution", nil, { RightLabel = (not (text(data.name)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'attribution du group:", nil, 55, false)
            if (input ~= nil) then
                data.name = input:lower()
            end
        end,
    })
    RageUI.Button("Nom d'affichage", nil, { RightLabel = (not (text(data.label)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Nom d'affichage du group:", nil, 55, false)
            if (input ~= nil) then
                data.label = input
            end
        end,
    })
    RageUI.Button("Position du grade", nil, { RightLabel = (not (text(data.id)) and _FlashClient_Utils.menu_label_change() or _FlashClient_Utils.menu_label_define()) }, true, {
        onSelected = function()
            local input = _FlashClient_Utils.input_showBox("Position:", nil, 55, true)
            local newPosition = tonumber(input)
            if ((newPosition > 0) and (newPosition ~= nil) and (not (getPositionExist(newPosition)))) then
                data.id = newPosition
            else
                _FlashClient_Utils.notifications_show("Cette position est déjà utilisé pour un grade")
            end
        end,
    })
    RageUI.Line()
    RageUI.Separator("~y~↓↓ ~r~Permissions ~y~↓↓")
    for _, permission in pairs(_Config.OrganisationPermission) do
        RageUI.Checkbox(("Perm : %s"):format(permission.label), ("~y~Description : ~s~%s"):format(permission.description), (checkGradePerm(permission.perm, data.permissions)), {}, {
            onChecked = function()
                table.insert(data.permissions, permission.perm)
            end,
            onUnChecked = function()
                for index, perm in pairs(data.permissions) do
                    if (permission.perm == perm) then
                        table.remove(data.permissions, index)
                    end
                end
            end
        })
    end
    if (not allInformationsDefine()) then
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 255, 0, 0 } } }, false, {})
    else
        RageUI.Button("Valider", nil, { Color = { BackgroundColor = { 0, 255, 0 } } }, true, {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("orga:newGrade", _FlashClient_Organisation_Boss.intraVars.name, data)
                data = {
                    name = nil,
                    label = nil,
                    id = nil,
                    permissions = {}
                }
            end,
        })
    end
end