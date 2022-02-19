--[[
  This file is part of FlashLand.
  Created at 19/02/2022 11:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Commands.registerCommandBasic = function(name, handler)
    RegisterCommand(name, function(_src, args)
        if (_src == 0) then
            return
        end
        if (#args == nil) then
            return
        end
        ---@type _Player
        local player = _FlashServer_Players.get(_src)
        handler(_src, player, args)
    end)
end