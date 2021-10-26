--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:20
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("joined", function()
    _FlashClient_Utils.screen_fade(0)
    _FlashClient_Utils.loading_show("FlashLand charge votre personnage", 4)
    _FlashClient_Utils.drawer_sprite()
    _FlashLand.toServer("connected")
end)