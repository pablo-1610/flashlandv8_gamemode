--[[
  This file is part of FlashLand.
  Created at 11/12/2021 01:34
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local billEvents = {}

_FlashServer_Billing.billEventExists = function(billEvent)
    return (billEvents[billEvent] ~= nil)
end

_FlashServer_Billing.triggerBillingEvent = function(billEvent, _src, method, args)
    if (not (_FlashServer_Billing.billEventExists(billEvent))) then
        return
    end
    billEvents[billEvent](_src, method, args)
end

_FlashServer_Billing.registerBillEvent = function(billEvent, handler)
    billEvents[billEvent] = function(_src, method, args)
        handler(_src, method, args)
    end
end