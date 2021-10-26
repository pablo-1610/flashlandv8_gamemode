--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.drawer_sprite = function(parent, component, x, y, width, height, heading, rgba)
    DrawSprite(parent, component, x, y, width, height, heading, rgba[1], rgba[2], rgba[3], rgba[4])
end