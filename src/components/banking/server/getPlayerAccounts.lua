--[[
  This file is part of FlashLand.
  Created at 10/12/2021 22:57
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Banking.getPlayerAccounts = function(_src, cb)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Database.query("SELECT * FROM flash_bankaccounts WHERE owner = @owner", {
        ["owner"] = ("player:%s"):format(player.flashId)
    }, function(result)
        local accounts = {}
        for _, row in pairs(result) do
            table.insert(accounts, _BankAccount(row.accountId, row.type, row.owner, row.label, row.pin, row.balance, row.state))
        end
        cb(accounts)
    end)
end