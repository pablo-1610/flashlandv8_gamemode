--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

gameType = _FlashEnum_GAMETYPE.RP
gameState = _FlashENUM_GAMESTATE.WAITING
isWaitingForServer = false

_FlashLand.setGameState = function(newGameState)
    gameState = newGameState
    if (gameState == _FlashENUM_GAMESTATE.PLAYING) then
        _FlashLand.toInternal("nowPlaying")
    end
end

_FlashLand.setIsWaitingForServer = function(newState)
    isWaitingForServer = newState
    if(isWaitingForServer) then
        CreateThread(function()
            _FlashClient_Utils.loading_show("En attente du serveur", 4)
            while (isWaitingForServer) do
                Wait(1)
            end
            _FlashClient_Utils.loading_hide()
        end)
    end
end

_FlashLand.toServer = function(event, ...)
    TriggerServerEvent(_FlashLand.format(event), ...)
    _FlashLand.log(("Envoie d'un event au serveur ^6>^1 %s"):format(event))
end

_FlashLand.toServerExposed = function(event, ...)
    TriggerServerEvent(event, ...)
    _FlashLand.log(("Envoie d'un event (^1Exposé^7) au serveur ^6>^1 %s"):format(event))
end

_FlashLand.onReceive("serverReturnedCb", function()
    _FlashLand.setIsWaitingForServer(false)
end)

CreateThread(function()
    _FlashLand.log("Demarrage du client...")
    _FlashLand.toInternal("loaded")
    while (true) do
        Wait(1)
        if (NetworkIsPlayerActive(PlayerId())) then
            _FlashLand.toInternal("joined")
            break
        end
    end
end)

_FlashLand.log("Bienvenue sur ^1FlashLand ^7!")