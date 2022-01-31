--[[
  This file is part of FlashLand.
  Created at 30/01/2022 19:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_Job_VehicleMenu.drawer[1] = function(player, vehicles)
    RageUI.Separator(("Garage ~b~%s"):format(player.job._job.label))
    RageUI.Line()
    RageUI.List("Emplacement:", _FlashClient_Job_VehicleMenu.intraVars.outPossibilitiesItems, _FlashClient_Job_VehicleMenu.intraVars.selectedOutPossibility, nil, {}, true, {
        onListChange = function(index)
            _FlashClient_Job_VehicleMenu.intraVars.selectedOutPossibility = index
        end,
        onActive = function()
            local position = _FlashClient_Job_VehicleMenu.intraVars.outPossibilities[_FlashClient_Job_VehicleMenu.intraVars.selectedOutPossibility]
            DrawMarker(2, position.x, position.y, position.z + 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
        end
    })
    RageUI.Line()
    for _, vehicle in pairs(vehicles) do
        RageUI.Button(vehicle[2], nil, { RightLabel = "→" }, true, {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("job:outVehicleFromGarage", vehicle[1], _FlashClient_Job_VehicleMenu.intraVars.jobId, _FlashClient_Job_VehicleMenu.intraVars.selectedOutPossibility, _FlashClient_Job_VehicleMenu.intraVars.zoneId)
            end,
            onActive = function()
                local position = _FlashClient_Job_VehicleMenu.intraVars.outPossibilities[_FlashClient_Job_VehicleMenu.intraVars.selectedOutPossibility]
                DrawMarker(2, position.x, position.y, position.z + 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
            end
        }, nil)
    end
end