--[[
  This file is part of FlashLand.
  Created at 18/12/2021 17:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("barber:cbPlayerQuitChair", function(barberId)
    _ConfigServer.BarberShop.list[barberId].seat.status = false
end)