--[[
  This file belongs to the Pablo Tebex store
  Created at 11/12/2021 02:20
  
  Copyright (c) Pablo Tebex Store - All Rights Reserved
--]]
---@author Pablo_1610

_FlashLand.onReceive("billing:setAsPaid", function()
    _FlashClient_Billing.currentBillingPaid = true
end)