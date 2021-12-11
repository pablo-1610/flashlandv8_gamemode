--[[
  This file is part of FlashLand.
  Created at 11/12/2021 01:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("banking:requestAccountsForBilling", function()
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
        _FlashLand.toClient("billing:callBackAccounts", _src, accounts)
    end)
end)