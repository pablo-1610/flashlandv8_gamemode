--[[
  This file is part of FlashLand.
  Created at 10/12/2021 21:46
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("nowPlaying", function()
    --[[
    CreateThread(function()
        while (true) do
            if (GetPlayerWantedLevel(PlayerId()) > 0) then
                ClearPlayerWantedLevel(PlayerId())
            end
            Wait(1)
        end
    end)
    --]]

    CreateThread(function()
        while (true) do
            if (GetPlayerWantedLevel(PlayerId()) > 0) then
                ClearPlayerWantedLevel(PlayerId())
            end
            Wait(2000)
        end
    end)
end)