--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local radar = true

_FlashClient_PlayerMenu.drawer[7] = function()
    RageUI.Checkbox("Radar", nil, radar, {}, {
        onSelected = function(newState)
            radar = newState
            DisplayRadar(radar)
        end
    })

    RageUI.Button("Sauvegarder", nil, {}, true, {
        onSelected = function()
            _FlashLand.setIsWaitingForServer(true)
            _FlashLand.toServer("player:requestSave")
        end
    })
end