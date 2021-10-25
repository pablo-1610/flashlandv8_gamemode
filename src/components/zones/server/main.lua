--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Zones
_FlashServer_Zones = {}

local count = 0
local list = {}

_FlashLand.onReceiveWithoutNet("loaded", function()
    CreateThread(function()
        while (true) do
            Wait(500)
            -- TODO -> Implement zones
        end
    end)
end)

_FlashLand.log("Chargement du composant: ^3zones")