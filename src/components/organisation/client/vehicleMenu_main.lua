--[[
  This file is part of FlashLand.
  Created at 19/02/2022 12:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Vehicle.drawer[1] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Vehicle.intraVars.label))
    RageUI.Separator(("Nombre de véhicule différent : ~r~%s"):format(_FlashLand.countTable(_FlashClient_Organisation_Vehicle.intraVars.vehicles)))
    RageUI.Line()
    for _, vehicle in pairs(_FlashClient_Organisation_Vehicle.intraVars.vehicles) do
        RageUI.Button(("%s"):format(vehicle.label), nil, { RightLabel = "~r~→→" }, (checkPerm("orga.openSpawnVehicle")), {
            onSelected = function()
                local model = GetHashKey(vehicle.name)
                if (not (IsModelValid(model))) then
                    _FlashClient_Utils.notifications_template_error(_Static_GenericMessages.INVALID_MODEL)
                else
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("orga:spawnVehicle", _FlashClient_Organisation_Vehicle.intraVars.name, model)
                end
            end,
        })
    end
end