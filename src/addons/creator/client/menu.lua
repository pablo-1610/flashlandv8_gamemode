--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:21
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("creator:initMenu", function()
    local main = RageUI.CreateMenu("Test", "Test", nil, nil, "root_cause", "")
    RageUI.Visible(main, true)
    CreateThread(function()
        while (true) do
            Wait(0)
            RageUI.IsVisible(main, function()
                RageUI.Button('Button', "test", {}, true, {});

            end)
        end
    end)
end)