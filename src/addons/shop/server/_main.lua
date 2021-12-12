--[[
  This file is part of FlashLand.
  Created at 11/12/2021 23:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

for shopId, shop in pairs(_ConfigServer.Shops.list) do
    ---@type _Blip
    local blip = _FlashServer_Blips.createPublic(shop.loc, 59, 69, _Config.genericBlipSize, ("Superette %s"):format(shop.type), true)

    ---@type _Npc
    local npc = _FlashServer_Npc.create(shop.npc, shop.npcHeading, "mp_m_shopkeep_01", false, true, 50.0)
    npc:setScenario("WORLD_HUMAN_CLIPBOARD_FACILITY", true)
    npc:setName("Apu", 0, 10.0)

    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(shop.loc, {255,255,255}, function(_src, player)
        npc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir parler au vendeur", 20.0, 1.0, true)
end