--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("nationalBank:openNationalBankMenu", function(_src, deskId, deskNpcId)
    ---@type _Npc
    local deskNpc = _FlashServer_Npc.get(deskNpcId)
    deskNpc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    _FlashServer_Banking.getPlayerAccounts(_src, function(accounts)
        _FlashLand.toClient("nationalBank:openMenu", _src, deskNpcId, _ConfigServer.NationalBank.accountCreationPrice, accounts)
    end)
end)