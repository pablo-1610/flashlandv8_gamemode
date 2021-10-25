--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.toServer = function(event, ...)
    TriggerServerEvent(FlashLand.format(event), ...)
    _FlashLand.log(("Envoie d'un event au serveur: %s"):format(event))
end

_FlashLand.toServerExposed = function(event, ...)
    TriggerServerEvent(event, ...)
    _FlashLand.log(("Envoie d'un event (^1Exposé^7) au serveur: %s"):format(event))
end

CreateThread(function()
    _FlashLand.log("Demarrage du client...")
    _FlashLand.toInternal("loaded")
end)