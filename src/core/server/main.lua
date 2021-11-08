--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.toClient = function(event, targetSrc, ...)
    TriggerClientEvent(_FlashLand.format(event), targetSrc, ...)
    _FlashLand.log(("Envoie d'un event au client (^3%i^7) ^6>^1 %s"):format(targetSrc, event))
end

_FlashLand.toClients = function(event, ...)
    TriggerClientEvent(_FlashLand.format(event), -1, ...)
    _FlashLand.log(("Envoie d'un event aux clients ^6>^1 %s"):format(event))
end

_FlashLand.serverResponded = function(target)
    _FlashLand.toClient("serverResponded", target, true)
end

_FlashLand.toClientExposed = function(event, targetSrc, ...)
    TriggerClientEvent(event, targetSrc, ...)
    _FlashLand.log(("Envoie d'un event (^1Exposé^7) au client (^3%s^7) ^6>^1 %s"):format(targetSrc, event))
end

CreateThread(function()
    _FlashLand.log(("Initialisation FlashLand version ^0%s"):format(_FlashServer_Versioning.getCurrentVersion()))
    _FlashLand.log("Demarrage du serveur...")
    _FlashLand.toInternal("loaded")
end)