--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Npc.deleteNpc = function(entityHandler)
    if (DoesEntityExist(entityHandler)) then
        DeleteEntity(entityHandler)
    end
end