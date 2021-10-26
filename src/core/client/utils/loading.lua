--[[
  This file is part of FlashLand.
  Created at 26/10/2021 23:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.loading_show = function(loadingText, spinnerType)
    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
    end
    if (loadingText == nil) then
        BeginTextCommandBusyString(nil)
    else
        BeginTextCommandBusyString("STRING");
        AddTextComponentSubstringPlayerName(loadingText);
    end
    EndTextCommandBusyString(spinnerType)
end

_FlashClient_Utils.loading_hide = function()
    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
    end
end