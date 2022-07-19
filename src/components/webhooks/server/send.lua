--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Webhooks.send = function(webhookData, message)
    if _Environment == nil then
        return
    end
    local webhookUrl = webhookData[1]
    -- Fivem discord webhook
    local webhook = {
        ["content"] = ("[`%s`] %s"):format(_Environment.serverId, message),
        ["username"] = "Système FlashLand",
        ["avatar_url"] = "https://ak.picdn.net/shutterstock/videos/1024557125/thumb/1.jpg",
        ["tts"] = false
    }
    PerformHttpRequest(webhookUrl, function(err, text, headers)
    end, 'POST', json.encode(webhook), { ['Content-Type'] = 'application/json' })
end