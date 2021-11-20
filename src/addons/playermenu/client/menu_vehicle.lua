--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_PlayerMenu.drawer[6] = function()
    if (not (_FlashClient_Utils.ped_isDriver(PlayerPedId()))) then
        RageUI.GoBack()
    else
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        -- TODO → Vehicle menu
    end
end