--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.usage = function(name, args, client)
    local sb = ("Utilisation: %s/%s"):format((client and "~y~" or "^3") ,name:lower())
    for _, arg in pairs(args) do
        sb = (sb..(" (%s)"):format(arg))
    end
    return (sb)
end