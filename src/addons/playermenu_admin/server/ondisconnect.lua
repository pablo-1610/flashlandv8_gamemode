--[[
  This file is part of FlashLand.
  Created at 16/11/2021 23:54
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNetExposed("playerDropped", function()
    local _src = source
    if(_FlashServer_Staff.isActive(_src)) then
        _FlashServer_Staff.removeFromActives(_src)
    end
end)