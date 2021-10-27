--[[
  This file is part of FlashLand.
  Created at 27/10/2021 19:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.notifications_show = function(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(0, 1)
end

_FlashClient_Utils.notifications_showAdvanced = function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    if saveToBrief == nil then
        saveToBrief = true
    end
    AddTextEntry("anotif", msg)
    BeginTextCommandThefeedPost("anotif")
    if hudColorIndex then
        ThefeedNextPostBackgroundColor(hudColorIndex)
    end
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

_FlashClient_Utils.notifications_template_error = function(message)
    _FlashClient_Utils.notifications_showAdvanced("Système", "~r~Erreur", message, _FlashEnum_CHARACTERPICTURE.SYSTEM, _FlashEnum_MESSAGEICONTYPE.CHAT)
end

_FlashClient_Utils.notifications_template_success = function(message)
    _FlashClient_Utils.notifications_showAdvanced("Système", "~g~Succès", message, _FlashEnum_CHARACTERPICTURE.SYSTEM, _FlashEnum_MESSAGEICONTYPE.CHAT)
end
