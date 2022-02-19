--[[
  This file is part of FlashLand.
  Created at 06/02/2022 12:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashClient_Organisation
_FlashClient_Organisation = {}

_FlashClient_Organisation.hasPermission = function(perm)
    ---@type _Player
    local player = _FlashClient_Cache.getPlayer()
    for _, permission in pairs(player.orga.grade.permission) do
        if (perm == permission) then
            return (true)
        end
    end
    return (false)
end