--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Phone
_FlashServer_Phone = {}

local playerCall = {}

_FlashServer_Phone.playerCall = function(identifier)
    return (playerCall[identifier] ~= nil)
end

_FlashServer_Phone.startPlayerCall = function(identifier)
    playerCall[identifier] = true
end

_FlashServer_Phone.finishPlayerCall = function(identifier)
    playerCall[identifier] = nil
end

_FlashServer_Phone.getPlayerInformationFromNumber = function(number)
    local allPlayers = _FlashServer_Players.getAll()
    for _, player in pairs(allPlayers) do
        if (player.number == number) then
            return (player)
        end
    end
    return (nil)
end

_FlashServer_Phone.getContactIsOnline = function(number)
    local isConnect = false
    local target = _FlashServer_Phone.getPlayerInformationFromNumber(number)
    if (target ~= nil) then
        isConnect = true
    end
    return (isConnect)
end

_FlashLand.loadedComponent("phone")