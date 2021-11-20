--[[
  This file is part of FlashLand.
  Created at 16/11/2021 23:57
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_PlayerMenu.drawer[5] = function(player, closestData, isStaffModeActive)
    RageUI.Checkbox("Mode administration", nil, isStaffModeActive, {}, {
        onChecked = function()
            _FlashClient_Staff.setCurrentActive(true)
            _FlashLand.setIsWaitingForServer(true)
            _FlashLand.toServer("staff:onToggle", true)
        end,

        onUnChecked = function()
            _FlashClient_Staff.setCurrentActive(false)
            _FlashLand.setIsWaitingForServer(true)
            _FlashLand.toServer("staff:onToggle", false)
        end
    })

    if(isStaffModeActive) then
        RageUI.Line()
        RageUI.Button("Mon personnage", nil, {RightLabel = "→"}, isStaffModeActive, {}, _FlashClient_PlayerMenu.getMenus()[10])
        RageUI.Button(("Gestion des joueurs (~r~%s~s~)"):format(_FlashLand.countTable(_FlashClient_Staff.getPlayerList())), nil, {RightLabel = "→"}, isStaffModeActive, {}, _FlashClient_PlayerMenu.getMenus()[9])
        RageUI.Button(("Gestion des véhicules (~r~%s~s~)"):format(_FlashLand.countTableIp(_FlashClient_Utils.entityiter_vehicles())), nil, {RightLabel = "→"}, isStaffModeActive, {}, _FlashClient_PlayerMenu.getMenus()[11])
    end
end