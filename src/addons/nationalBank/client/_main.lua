--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:05
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_NationalBank
_FlashClient_NationalBank = {}

_FlashClient_NationalBank.var = {
    deskNpcId = nil,
    accountCreationPrice = nil,
    accountBuilder = {
        pin = nil,
        label = nil,
        type = nil,
    },
    accounts = nil,
    selectedAccount = nil,
}