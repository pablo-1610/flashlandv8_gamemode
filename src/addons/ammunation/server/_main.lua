--[[
  This file is part of FlashLand.
  Created at 15/12/2021 15:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

for k,v in pairs(_ConfigServer.Ammunation.list) do
    ---@type _Blip
    local blip = _FlashServer_Blips.createPublic(v.position, 313, 49, _Config.genericBlipSize, "Ammunation", true)

    ---@type _Npc
    local npc = _FlashServer_Npc.create(v.npcPosition, v.npcHeading, "s_m_m_ammucountry", false, true, 50.0)
    npc:setScenario("WORLD_HUMAN_CLIPBOARD_FACILITY", true)

    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(v.position, {255,0,0}, function(_src, player, lightZone)
        _FlashLand.toInternal("ammunation:openMenu", _src, npc.id)
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler à l'armurier", 10.0, 1.0, true, _FlashUtils.math_getInversedHeading(v.npcHeading))
end