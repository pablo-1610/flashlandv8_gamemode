--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local deskZone = {}
local deskNpc = {}

_FlashServer_Blips.createPublic(vector3(249.22, 217.81, 106.28), 106, 30, _Config.genericBlipSize, true, "Banque nationale")

for _, location in pairs(_ConfigServer.NationalBank.guards) do
    ---@type _Npc
    local guard = _FlashServer_Npc.create(location.position, location.heading, "s_m_m_security_01", false, true, 30.0)
    guard:setScenario("WORLD_HUMAN_GUARD_STAND", true)
end

for deskId, deskData in pairs(_ConfigServer.NationalBank.desks) do
    ---@type _Npc
    local npc = _FlashServer_Npc.create(deskData.ped.position, deskData.ped.heading, _ConfigServer.NationalBank.pedModel, false, true, 20.0)
    npc:setName("Banquier", 0, 10.0)
    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(deskData.position, {255,255,255}, function(_src, player)
        npc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler au conseiller", 20.0, 1.0, true)
end