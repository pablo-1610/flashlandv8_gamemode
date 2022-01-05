--[[
  This file is part of FlashLand.
  Created at 31/12/2021 17:17
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("applySkinDefaultSkin", function()
    local defaultSkin = _FlashClient_SkinChanger.getCharacter()
    _FlashClient_SkinChanger.applySkin(defaultSkin)
end)