--[[
  This file is part of FlashLand.
  Created at 09/11/2021 22:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local running = false

local function createPopulatorTask()
    if (running) then
        _FlashLand.err("Populator est déjà en train de tourner")
        return
    end
    running = true
    CreateThread(function()
        while (running) do
            Wait(1500)
            -- TODO -> Populator
        end
    end)
end

_FlashLand.onReceiveWithoutNet("populator:init", function()
    createPopulatorTask()
end)