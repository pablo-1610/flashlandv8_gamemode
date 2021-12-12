--[[
  This file is part of FlashLand.
  Created at 12/12/2021 21:48
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.setPin = function(accountId, newPin, cb)
    _FlashServer_Database.execute("UPDATE flash_bankaccounts SET pin = @pin WHERE accountId = @accountId", {
        ["@pin"] = newPin,
        ["@accountId"] = accountId
    }, function()
        cb()
    end)
end