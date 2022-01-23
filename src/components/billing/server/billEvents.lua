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

_FlashServer_Billing.triggerBillingEvent = function(billEvent, _src, method, total, args)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Billing.billEventExists(billEvent))) then
        return
    end
    CreateThread(function()
        _FlashServer_Webhooks.send(_Webhooks.BILLING, ("[%s] __%s__ (%s) a payé `%s` [%s] pour **%s$**.\n```%s```"):format(player.rank.label, player.name, player.flashId, billEvent, _FlashEnum_BILLINGPAYMENTMETHODLABEL[method], total, json.encode(args)))
        if (method == _FlashEnum_BILLINGPAYMENTMETHOD.CARD) then
            _FlashServer_Webhooks.send(_Webhooks.BANK_BILLING, ("[%s] __%s__ (%s) a utilisé le compte `#%s` pour payer `%s` d'un total de **%s$**"):format(player.rank.label, player.name, player.flashId, args.accountId, billEvent, _FlashUtils.math_group(total)))
        end
    end)
    billEvents[billEvent](_src, method, total, args)
end

_FlashServer_Billing.registerBillEvent = function(billEvent, handler)
    billEvents[billEvent] = function(_src, method, total, args)
        handler(_src, method, total, args)
    end
end