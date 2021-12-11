--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _BankAccount
---@field public accountId number
---@field public type number
---@field public owner string
---@field public label string
---@field public pin number
---@field public balance number
_BankAccount = {}
_BankAccount.__index = _BankAccount

setmetatable(_BankAccount, {
    __call = function(_, accountId, type, owner, label, pin, balance)
        local self = setmetatable({}, _BankAccount)
        self.accountId = accountId
        self.type = type
        self.owner = owner
        self.label = label
        self.pin = pin
        self.balance = balance
        return (self)
    end
})