--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Tattoo
_FlashServer_Tattoo = {}

local function getInverseHeading(heading)
    return (heading + 180) % 360
end

for tattooId, tattoo in pairs(_ConfigServer.TattooShop.list) do
    ---@type _Blip
    local blip = _FlashServer_Blips.createPublic(tattoo.position, 75, 1, _Config.genericBlipSize, "Tattoo Shop", true)

    ---@type _Npc
    local npc = _FlashServer_Npc.create(tattoo.npcPosition, tattoo.npcHeading, "u_m_y_tattoo_01", false, true, 50.0)
    npc:setScenario("WORLD_HUMAN_GUARD_STAND", true)

    if (_Config.environment == _FlashEnum_ENV.DEV) then
        npc:setName(("[DEBUG] SHOPID %s"):format(tattooId), 0, 10.0)
    end

    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(tattoo.position, { 255, 255, 255 }, function(_src, player)
        --_FlashLand.toInternal("shop:openTattooMenu", _src, tattooId, npc.id)
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler au Tatoueur", 20.0, 1.0, true, getInverseHeading(tattoo.npcHeading))
end