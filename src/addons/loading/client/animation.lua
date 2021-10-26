--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashClient_Utils.screen_reveal(0)
    _FlashClient_Utils.loading_show("FlashLand charge votre personnage", 4)
    CreateThread(function()
        Wait(1000)
        print("Chargement")
        _FlashClient_Utils.memory_loadDict("flashland")
        print("Super")
        print("LE N")
        while (gameState == _FlashENUM_GAMESTATE.WAITING) do
            DrawSprite("flashland", "logo_transparent", 0.5, 0.5,0.3, 0.5, 0.0, 255, 255, 255, 255)
            Wait(0)
        end
    end)
end)