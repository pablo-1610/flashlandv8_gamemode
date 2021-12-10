--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _BankAccount
---@field public uniqueId number
---@field public owner string
---@field public type number
---@field public balance number
---@field public pin number
_BankAccount = {}
_BankAccount.__index = _BankAccount

setmetatable(_BankAccount, {
    __call = function(_, uniqueId, owner, type, balance, pin)
        local self = setmetatable({}, _BankAccount)
        self.uniqueId = uniqueId
        self.owner = owner
        self.type = type
        self.balance = balance
        self.pin = pin
        return (self)
    end
})