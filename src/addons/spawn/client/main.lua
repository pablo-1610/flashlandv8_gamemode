--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
--[[
_FlashLand.onReceive("joined", function()
    _FlashLand.log("Tentative de spawn le joueur...")
    _FlashClient_Utils.ped_spawn("mp_m_freemode_01", { x = 686.26, y = 577.86, z = 129.75, heading = 162.34 })
    _FlashLand.log("Spawn effectué")
end)
--]]

_FlashLand.log("Chargement de l'addon: ^3spawn")