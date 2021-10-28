--[[
  This file is part of FlashLand.
  Created at 28/10/2021 18:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---
local running = false
local interval = _ConfigServer.Synchronizer.position

local function savePlayersPosition()
    ---@param player _Player
    for _, player in pairs(_FlashServer_Players.getAll()) do
        player:savePosition()
    end
    _FlashLand.log("Position de tous les joueurs sauvegardée")
end

_FlashServer_Synchronizer.createPositionsThread = function()
    if (running) then
        return
    end
    running = true
    CreateThread(function()
        while (running) do
            Wait(interval)
            savePlayersPosition()
        end
    end)
end

_FlashServer_Synchronizer.destroyPositionsThread = function()
    if (not (running)) then
        return
    end
    running = false
    _FlashLand.log("Arrêt du synchronisateur de positions")
end

_FlashServer_Synchronizer.isPositionsSynchronizerRunning = function()
    return (running == true)
end