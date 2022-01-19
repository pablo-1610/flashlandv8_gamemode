--[[
  This file is part of FlashLand.
  Created at 11/01/2022 21:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[22] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedOrganisation ~= nil) then
        local organisation = _FlashClient_Staff.getOrganisationList()
        local organisationData = organisation[_FlashClient_PlayerMenu.var.selectedOrganisation]
        RageUI.Separator(("Organisation : ~b~%s"):format(organisationData.jobLabel))
        RageUI.Line()
        perm = "admin.deleteOrga"
        RageUI.Button(("%s~r~Supprimer l'organisation"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:deleteOrganisation", organisationData.jobName)
                _FlashClient_PlayerMenu.var.selectedOrganisation = nil
            end,
        })
        RageUI.Line()
        perm = "admin.openOrgaGrade"
        RageUI.Button(("%sAfficher tous les grades"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {}, _FlashClient_PlayerMenu.getMenus()[23])
        RageUI.Separator("~o~↓↓ ~r~ACTION PATRON ~o~↓↓")
        perm = "admin.moveOrgaPoint"
        RageUI.Button(("%s -> Déplacer"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:moveBossActionOrganisation", organisationData.jobName)
            end,
        })
        RageUI.Separator("~o~↓↓ ~r~COFFRE ~o~↓↓")
        RageUI.Button(("%s -> Déplacer"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:moveCoffreOrganisation", organisationData.jobName)
            end,
        })
        RageUI.Separator("~o~↓↓ ~r~GARAGE ~o~↓↓")
        RageUI.Button(("%s -> Déplacer le menu + spawn véhicule"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:moveSpawnVehicleOrganisation", organisationData.jobName)
            end,
        })
        RageUI.Button(("%s -> Déplacer le rangement véhicule"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:moveDeleteVehicleOrganisation", organisationData.jobName)
            end,
        })
        RageUI.Separator("~o~↓↓ ~r~BLIP ~o~↓↓")
        RageUI.Button(("%s -> Déplacer"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, {}, (checkPerm(perm)), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:moveBlipOrganisation", organisationData.jobName)
            end,
        })
    end
end