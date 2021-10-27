--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:07
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.screen_radar = function(bool)
    DisplayRadar(bool)
end

_FlashClient_Utils.screen_fade = function(duration, waitUntilFinished)
    DoScreenFadeOut(duration)
    if (waitUntilFinished) then
        while (not (IsScreenFadedOut())) do
            Wait(0)
        end
    end
end

_FlashClient_Utils.screen_reveal = function(duration, waitUntilFinished)
    DoScreenFadeIn(duration)
    if (waitUntilFinished) then
        while (not (IsScreenFadedIn())) do
            Wait(0)
        end
    end
end