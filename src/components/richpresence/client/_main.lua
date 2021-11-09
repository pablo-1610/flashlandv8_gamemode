--[[
  This file is part of FlashLand.
  Created at 08/11/2021 23:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_RichPresence
_FlashClient_RichPresence = {}

local appId = 0
local running = false

_FlashClient_RichPresence.initialize = function(id)
    appId = id
    SetDiscordAppId(id)
    _FlashClient_RichPresence.setPresence(_FlashEnum_RICHPRESENCE.CONNECTING)
    _FlashClient_RichPresence.requestVersion()
end

_FlashClient_RichPresence.requestVersion = function()
    _FlashLand.onReceive("richpresence:cbVersion", function(version)
        SetDiscordRichPresenceAssetSmall("flashguy")
        SetDiscordRichPresenceAssetSmallText(("FlashLand [Env. → %s] {%s}"):format(_Config.environment,version))
    end)
    _FlashLand.toServer("richpresence:getVersion")
end

_FlashClient_RichPresence.setPresence = function(presenceEnum)
    presenceEnum()
end

_FlashLand.loadedComponent("richPresence")