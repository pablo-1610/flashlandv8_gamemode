--[[
  This file is part of FlashLand.
  Created at 11/12/2021 13:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.deleteAccount = function(accountId, cb)
    _FlashServer_Database.execute("DELETE FROM flash_bankaccounts WHERE accountId = @accountId", {
        ["accountId"] = accountId
    }, function()
        cb()
    end)
end