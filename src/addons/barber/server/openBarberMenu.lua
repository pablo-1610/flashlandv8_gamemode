--[[
  This file is part of FlashLand.
  Created at 18/12/2021 13:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNet("barber:openBarberMenu", function(_src, barberId, barberInformation)
    local barberData = _ConfigServer.BarberShop.list[barberId]
    ---@type _Npc
    local barberNpc = barberData.npc
    barberNpc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    _FlashLand.toClient("barber:openMenu", _src, barberId, barberData, barberInformation)
end)