--[[
  This file is part of FlashLand.
  Created at 11/12/2021 15:37
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.withdrawFromAccount = function(accountId, amount, cb)
    _FlashServer_Database.execute("UPDATE flash_bankaccounts SET balance = (balance - @amount) WHERE accountId = @accountId", {
        ["accountId"] = accountId,
        ["amount"] = amount
    }, function()
        cb()
    end)
end