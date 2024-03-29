--[[
  This file is part of FlashLand.
  Created at 13/12/2021 22:09
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:33

  Copyright (c) FlashLand - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Barber
_FlashServer_Barber = {}

local function getInverseHeading(heading)
    return (heading + 90) % 360
end

for barberId, barber in pairs(_ConfigServer.BarberShop.list) do
    ---@type _Blip
    local blip = _FlashServer_Blips.createPublic(barber.position, 71, 55, _Config.genericBlipSize, "Coiffeur", true)

    ---@type _Npc
    local npc = _FlashServer_Npc.create(barber.npcPosition, barber.npcHeading, "u_m_y_tattoo_01", false, true, 50.0)
    npc:setScenario("WORLD_HUMAN_GUARD_STAND", true)
    _ConfigServer.BarberShop.list[barberId].npc = npc

    if (_Config.environment == _FlashEnum_ENV.DEV) then
        npc:setName(("[DEBUG] SHOPID %s"):format(barberId), 0, 10.0)
    end

    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(barber.position, { 255, 255, 255 }, function(_src, player)
        if (not (barber.seat.status)) then
            local barberInformation = _ConfigServer.BarberShop
            _ConfigServer.BarberShop.list[barberId].seat.status = true
            _FlashLand.toInternal("barber:openBarberMenu", _src, barberId, barberInformation)
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, _Static_GenericMessages.BARBER_SHOP_NOT_CHAIR_AVAILABLE)
        end
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler au Coiffeur", 20.0, 1.0, true, getInverseHeading(barber.npcHeading))
end