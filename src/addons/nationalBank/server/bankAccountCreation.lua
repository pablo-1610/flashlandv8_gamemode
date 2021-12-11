--[[
  This file belongs to the Pablo Tebex store
  Created at 11/12/2021 02:12
  
  Copyright (c) Pablo Tebex Store - All Rights Reserved
--]]
---@author Pablo_1610

_FlashServer_Billing.registerBillEvent("create_bank_account", function(_src, method, args)
    ---@type _Npc
    local npc = _FlashServer_Npc.get(args.deskNpcId)
    npc:sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")
    local data = args.accountInfos
    _FlashLand.toInternal("nationalBank:createPlayerBankAccount", _src, data.pin, data.label)
end)