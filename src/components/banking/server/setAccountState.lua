--[[
  This file is part of FlashLand.
  Created at 11/12/2021 13:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.setAccountState = function(accountId, newState, cb)
    _FlashServer_Database.execute("UPDATE flash_bankaccounts SET state = @state WHERE accountId = @accountId", {
        ["accountId"] = accountId,
        ["state"] = newState
    }, function()
        cb()
    end)
end