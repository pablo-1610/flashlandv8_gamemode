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
    _FlashClient_RichPresence.setInfos()
end

_FlashClient_RichPresence.setInfos = function()
    SetDiscordRichPresenceAssetSmall("flashguy")
    SetDiscordRichPresenceAssetSmallText(("FlashLand [PRE-0.04:%s]"):format(_Config.environment))
end

_FlashClient_RichPresence.setPresence = function(presenceEnum)
    presenceEnum()
end

_FlashLand.loadedComponent("richPresence")