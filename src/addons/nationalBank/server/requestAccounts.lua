--[[
  This file is part of FlashLand.
  Created at 11/12/2021 04:14
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("nationalBank:requestAccounts", function()
    local _src = source
    _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
        _FlashLand.toClient("nationalBank:cbAccounts", _src, accounts)
    end)
end)