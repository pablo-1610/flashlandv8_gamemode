--[[
  This file is part of FlashLand.
  Created at 09/11/2021 00:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashEnum_RICHPRESENCE = {
    CONNECTING = function()
        SetRichPresence("Arrive en ville... ✈️")
        SetDiscordRichPresenceAsset("connecting") -- The name of the big picture you added in the application.
        SetDiscordRichPresenceAssetText("discord.gg/flashland")
    end
}