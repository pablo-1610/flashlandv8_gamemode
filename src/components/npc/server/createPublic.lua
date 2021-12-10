--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:09
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Npc.createPublic = function(position, heading, model, ai, frozen, drawDist)
    local id = _FlashServer_Npc.getNextId()
    local npc = _Npc(id, position, heading, model, ai, frozen, drawDist)
    _FlashServer_Npc.add(npc)
    return (npc)
end