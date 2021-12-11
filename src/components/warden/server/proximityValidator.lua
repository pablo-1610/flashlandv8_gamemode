--[[
  This file is part of FlashLand.
  Created at 11/12/2021 17:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Warden.isCloseEnoughToInteract = function(pedA, pedB)
    local distA, distB = GetEntityCoords(pedA), GetEntityCoords(pedB)
    return (#(distA - distB) < 3.5)
end