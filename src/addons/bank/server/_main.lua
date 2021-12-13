--[[
  This file is part of FlashLand.
  Created at 12/12/2021 18:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

for bankId, bankData in pairs(_ConfigServer.Banks.list) do
    -- Npcs
    ---@type _Npc
    local npc = _FlashServer_Npc.create(bankData.npcPos, bankData.npcHeading, _ConfigServer.Banks.pedModel, false, true, 40.0)
    ---@type _Npc
    local guard = _FlashServer_Npc.create(bankData.guard.position, bankData.guard.heading, "s_m_m_security_01", false, true, 30.0)
    guard:setScenario("WORLD_HUMAN_GUARD_STAND", true)

    -- Zones
    ---@type _Zone
    local desk = _FlashServer_Zones.createPublic(bankData.position, { 255, 255, 255 }, function(_src, player, lightZone)
        _FlashLand.toInternal("bank:openBankMenu", _src, bankId, npc.id)
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler à la conseillère", 20.0, 1.0, true, _FlashUtils.math_getInversedHeading(bankData.npcHeading))

    -- Blips
    local blip = _FlashServer_Blips.createPublic(bankData.position, 278, 24, _Config.genericBlipSize + 0.45, "Banque Fleeca", true)
end