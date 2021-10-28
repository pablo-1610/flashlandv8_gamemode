--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("spawn:spawned", function()
    _FlashLand.toServer("players:onSpawn")
end)

_FlashLand.onReceive("spawn:spawn", function(spawn, skin, currentOutfit)
    local alreadyLoaded = (PlayerPedId() ~= nil and (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")))
    Wait(500)
    local model = "mp_m_freemode_01"
    _FlashClient_Utils.memory_load(model)
    if(not (alreadyLoaded)) then
        _FlashClient_Utils.ped_spawn("mp_m_freemode_01", { x = spawn.coords.x, y = spawn.coords.x, z = spawn.coords.x, heading = spawn.heading})
        while (#(GetEntityCoords(PlayerPedId())-vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z)) >= 5) do
            SetEntityCoords(PlayerPedId(), spawn.coords.x, spawn.coords.y, spawn.coords.z)
            Wait(10)
        end
    end
    _FlashClient_SkinChanger.setAllToDefault()
    _FlashLand.log("Chargement du skin")
    if (skin["sex"] == 1) then
        local model = "mp_f_freemode_01"
        _FlashClient_Utils.memory_load(model)
        SetPlayerModel(PlayerId(), model)
        _FlashClient_SkinChanger.setAllToDefault()
    end
    _FlashClient_SkinChanger.applySkin(skin)
    _FlashLand.log("Chargement des vêtements")
    _FlashClient_SkinChanger.applySkin(currentOutfit)
    _FlashLand.toInternal("spawn:spawned")
    _FlashClient_Utils.loading_hide()
end)

_FlashLand.log("Chargement de l'addon: ^3spawn")