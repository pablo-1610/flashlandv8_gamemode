--[[
  This file is part of FlashLand.
  Created at 16/11/2021 23:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("playerMenu:showIdCard", function(playerSource, playerIdentity)
    local otherPed = GetPlayerPed(GetPlayerFromServerId(playerSource))
    local mugshot, mugshotStr = _FlashClient_Utils.ped_getMugShot(otherPed)
    _FlashClient_Utils.notifications_showAdvanced("Carte d'identité", ("~o~%s %s ~s~(~o~%s ans~s~)"):format(playerIdentity.firstname, playerIdentity.lastname, playerIdentity.age), "", mugshotStr, _FlashEnum_MESSAGEICONTYPE.ARROW, false)
end)