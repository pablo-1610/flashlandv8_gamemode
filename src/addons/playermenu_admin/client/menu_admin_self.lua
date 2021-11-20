--[[
  This file is part of FlashLand.
  Created at 20/11/2021 13:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local noClip, names, blips = false, false, false

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

_FlashClient_Staff.getNoClipState = function()
    return (noClip)
end

_FlashClient_Staff.getNamesState = function()
    return (names)
end

_FlashClient_Staff.getBlipsState = function()
    return (blips)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[10] = function(player)
    local perm = nil
    RageUI.Separator(("Rang: %s%s"):format(player.rank.baseColor, player.rank.label))

    RageUI.Line()

    perm = "admin.noclip"
    RageUI.Checkbox(("%s%sNoClip"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), _FlashClient_Utils.menu_display_greenIfTrue(noClip)), nil, noClip, {}, {
        onChecked = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
                return
            end
            noClip = true
            _FlashLand.toInternal("admin:toggleNoClip", true)
        end,
        onUnChecked = function()
            noClip = false
        end
    })

    perm = "admin.names"
    RageUI.Checkbox(("%s%sAfficher les noms"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), _FlashClient_Utils.menu_display_greenIfTrue(names)), nil, names, {}, {
        onChecked = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
                return
            end
            names = true
            _FlashLand.toInternal("admin:toggleNames", true)
        end,
        onUnChecked = function()
            names = false
        end
    })

    perm = "admin.blips"
    RageUI.Checkbox(("%s%sAfficher les blips"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), _FlashClient_Utils.menu_display_greenIfTrue(blips)), nil, blips, {}, {
        onChecked = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
                return
            end
            blips = true
            _FlashLand.toInternal("admin:toggleBlips", true)
        end,
        onUnChecked = function()
            blips = false
        end
    })

    RageUI.Line()

    perm = "admin.tpwaypoint"
    RageUI.Button(("%sTéléportation au marqueur"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, checkPerm(perm), {
        onSelected = function()
            if (not (checkPerm(perm))) then
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.NO_PERM)
                return
            end
            local blip = GetFirstBlipInfoId(8)
            if (DoesBlipExist(blip)) then
                CreateThread(function()
                    local waypointCoords = GetBlipInfoIdCoord(blip)
                    local foundGround, zCoords, zPos = false, -500.0, 0.0
                    while (not (foundGround)) do
                        zCoords = zCoords + 10.0
                        RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                        Wait(0)
                        foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)
                        if (not (foundGround) and zCoords >= 2000.0) then
                            foundGround = true
                        end
                    end
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords.x, waypointCoords.y, zPos)
                end)
            else
                _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.INVALID_WAYPOINT)
            end
        end
    })
end