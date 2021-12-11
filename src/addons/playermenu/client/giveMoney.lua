--[[
  This file is part of FlashLand.
  Created at 11/12/2021 18:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("playerMenu:giveMoneyNotification", function(playerSource, playerIdentity, sender, subject, content)
    local otherPed = GetPlayerPed(GetPlayerFromServerId(playerSource))
    local mugshot, mugshotStr = _FlashClient_Utils.ped_getMugShot(otherPed)
    _FlashClient_Utils.notifications_showAdvanced(sender, subject, content, mugshotStr, _FlashEnum_MESSAGEICONTYPE.DOLLAR, false)
end)