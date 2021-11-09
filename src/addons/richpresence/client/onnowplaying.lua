--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("nowPlaying", function()
    _FlashClient_RichPresence.setPresence(_FlashEnum_RICHPRESENCE.INGAME)
end)