--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashClient_Utils.screen_fade(0)
    _FlashClient_Utils.loading_show("FlashLand charge votre personnage", 4)
    CreateThread(function()
        while (gameState == _FlashENUM_GAMESTATE.WAITING) do
            Wait(50)
        end
        _FlashClient_Utils.screen_reveal(3500)
        _FlashClient_Utils.loading_hide()
    end)
end)