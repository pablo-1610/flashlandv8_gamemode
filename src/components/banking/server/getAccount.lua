--[[
  This file is part of FlashLand.
  Created at 11/12/2021 12:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.getAccount = function(accountId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_bankaccounts WHERE accountId = @accountId", {
        ["accountId"] = accountId
    }, function(result)
        cb(result[1])
    end)
end