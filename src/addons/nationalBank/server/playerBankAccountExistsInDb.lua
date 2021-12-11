--[[
  This file is part of FlashLand.
  Created at 11/12/2021 02:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("nationalBank:playerBankAccountExistsInDb", function(flashId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_bankaccounts WHERE owner = @owner", {
        ["owner"] = ("player:%s"):format(flashId)
    }, function(result)
        cb(result[1] ~= nil)
    end)
end)