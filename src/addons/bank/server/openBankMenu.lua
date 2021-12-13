--[[
  This file is part of FlashLand.
  Created at 12/12/2021 18:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("bank:openBankMenu", function(_src, bankId, bankNpcId)
    ---@type _Npc
    local bankNpc = _FlashServer_Npc.get(bankNpcId)
    bankNpc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
        _FlashLand.toClient("bank:openMenu", _src, bankNpcId, accounts)
    end)
end)