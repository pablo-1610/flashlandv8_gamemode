--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.drawer_sprite = function(parent, component, x, y, width, height, heading, rgba)
    DrawSprite(parent, component, x, y, width, height, heading, rgba[1], rgba[2], rgba[3], rgba[4])
end

_FlashClient_Utils.drawer_spriteWithSmooth = function(check, parent, component, x, y, width, height, heading)
    local smooth = 1
    CreateThread(function()
        while (smooth <= 255) do
            smooth = (smooth+1)
            Wait(20)
        end
    end)
    CreateThread(function()
        print("Check")
        while (check()) do
            DrawSprite(parent, component, x, y, width, height, heading, 255, 255, 255, smooth)
            print(smooth)
            Wait(0)
        end
        print("No longer check")
        smooth = 255
        CreateThread(function()
            while (smooth >= 1) do
                smooth = (smooth-0.05)
                Wait(3)
            end
        end)
        CreateThread(function()
            while (smooth >= 1) do
                DrawSprite(parent, component, x, y, width, height, heading, 255, 255, 255, smooth)
                Wait(0)
            end
        end)
    end)
end

_FlashClient_Utils.drawer_textWithSmooth = function()  end