--[[
  This file is part of FlashLand.
  Created at 11/12/2021 17:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local teleportType = { _FlashEnum_TELEPORTATIONTYPE.STAFF_ON_PLAYER, _FlashEnum_TELEPORTATIONTYPE.PLAYER_ON_STAFF }
local teleportIndex = 1

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[15] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayer ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayer]
        RageUI.Separator(("Nom : ~b~%s"):format(playerData.name))
        RageUI.Separator(("Flash ID : ~b~%s"):format(playerData.flashId))
        RageUI.Separator(("ID : ~b~%s"):format(playerData.sId))
        RageUI.Line()
        perm = "admin.teleport"
        RageUI.List("Teleportation : ", teleportType, teleportIndex, nil, {}, (checkPerm(perm)), {
            onListChange = function(Index)
                teleportIndex = Index
            end,
            onSelected = function()
                if teleportIndex == 1 then
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:teleportStaffToPlayer", playerData.sId)
                elseif teleportIndex == 2 then
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:teleportPlayerToStaff", playerData.sId)
                end
            end,
        })
        perm = "admin.playerinv"
        RageUI.Button("Inventaire", nil, { RightLabel = "→" }, (checkPerm(perm)), {}, _FlashClient_PlayerMenu.getMenus()[16])
        perm = "admin.giveitem"
        RageUI.Button("Donner un item", nil, { RightLabel = "→" }, (checkPerm(perm)), {
            onSelected = function()
                _FlashClient_PlayerMenu.var.selectedPlayerAction = playerData.sId
                _FlashLand.toServer("item:requestLightItems")
            end
        }, _FlashClient_PlayerMenu.getMenus()[17])
        perm = "admin.giveweapon"
        RageUI.Button("Donner une arme", nil, { RightLabel = "→" }, (checkPerm(perm)), {
            onSelected = function()
                _FlashClient_PlayerMenu.var.selectedPlayerAction = playerData.sId
            end
        }, _FlashClient_PlayerMenu.getMenus()[18])
        RageUI.Line()
        perm = "admin.kickplayer"
        RageUI.Button("Kick", nil, {}, (checkPerm(perm)), {
            onSelected = function()
                local reason = _FlashClient_Utils.input_showBox("Raison du kick:", nil, 55, false)
                if (reason ~= nil) then
                    RageUI.GoBack()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:kickPlayer", playerData.sId, reason)
                    _FlashClient_PlayerMenu.var.selectedPlayer = nil
                end
            end,
        })
        perm = "admin.ban"
        RageUI.Button("Bannir", nil, {}, (checkPerm(perm)), {
            onSelected = function()
                local day = _FlashClient_Utils.input_showBox("Temps de ban en jour:", nil, 15, true)
                local dayOfBan = tonumber(day)
                if ((dayOfBan ~= nil) and (dayOfBan > 0)) then
                    local reason = _FlashClient_Utils.input_showBox("Raison du ban:", nil, 155, false)
                    if (reason ~= nil) then
                        RageUI.GoBack()
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:banPlayerConnect", playerData.sId, dayOfBan, reason)
                        _FlashClient_PlayerMenu.var.selectedPlayer = nil
                    end
                end
            end,
        })
        perm = "admin.vehspawn"
        RageUI.Button("Spawn un véhicule", nil, {}, (checkPerm(perm)), {
            onSelected = function()
                local input = _FlashClient_Utils.input_showBox("Modèle", "", 20, false)
                if (input ~= nil) then
                    input = input:lower()
                    local model = GetHashKey(input)
                    if (not (IsModelValid(model))) then
                        _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.INVALID_MODEL)
                    else
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("staff:spawnPlayerSelectedVehicule", playerData.sId, model)
                    end
                end
            end,
        })
    end
end