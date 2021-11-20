--[[
  This file is part of FlashLand.
  Created at 20/11/2021 16:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("admin:toggleNames", function(newState)
    if (newState) then
        CreateThread(function()
            while (_FlashClient_Staff.getNamesState()) do
                Wait(0)
                -- TODO → Names display
            end
        end)
    end
end)