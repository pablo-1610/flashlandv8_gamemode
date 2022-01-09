--[[
  This file is part of FlashLand.
  Created at 15/12/2021 15:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("ammunation:openMenu", function(_src, deskNpcId)
    ---@type _Npc
    local npc = _FlashServer_Npc.get(deskNpcId)
    npc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    _FlashLand.toClient("ammunation:openMenu", _src, deskNpcId, _ConfigServer.Ammunation.weapons)
end)