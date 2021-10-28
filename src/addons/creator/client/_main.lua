--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:20
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local defaultModels = {
    "mp_m_freemode_01",
    "mp_f_freemode_01"
}

_FlashLand.onReceive("creator:init", function()
    Wait(5000)
    local coords, heading = _ConfigClient.Creator.pedPosition.coords, _ConfigClient.Creator.pedPosition.heading
    _FlashClient_Synchronizer.setTimeOverride({12,00})
    _FlashClient_Synchronizer.setWeatherOverride("EXTRASUNNY")
    _FlashClient_Utils.screen_radar(false)
    _FlashClient_Utils.loading_show("Chargement de l'éditeur de personnage", 4)
    _FlashClient_Utils.memory_loadAll(defaultModels)
    _FlashClient_Utils.screen_fade(1500, true)
    _FlashClient_Utils.ped_spawn("mp_m_freemode_01", { x = coords.x, y = coords.y, z = coords.z, heading = _ConfigClient.Creator.pedPosition.heading})
    _FlashClient_SkinChanger.setAllToDefault()
    _FlashLand.toInternal("creator:initCamera")
    _FlashClient_Utils.ped_tp(PlayerPedId(), coords, heading)
    _FlashClient_Utils.ped_scenario(PlayerPedId(), "WORLD_HUMAN_GUARD_STAND_CLUBHOUSE", false)
    _FlashClient_Utils.screen_reveal(5000)
    _FlashLand.toInternal("creator:initMenu")
    SetTimeout(1500, function()
        _FlashClient_Utils.loading_hide()
    end)
end)

_FlashLand.log("Chargement de l'addon: ^3creator")