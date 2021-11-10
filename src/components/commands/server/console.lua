--[[
  This file is part of FlashLand.
  Created at 10/11/2021 01:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerConsoleCommand = function(name, handler)
    RegisterCommand(name, function(_src, args)
        if (_src ~= 0) then
            print("NO")
            return
        end
        handler(args)
    end)
end