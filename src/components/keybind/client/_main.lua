--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:40
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_KeyBind
_FlashClient_KeyBind = {}

local canUse = false

_FlashClient_KeyBind.addKey = function(defaultKey, desc, action)
    RegisterCommand(("+flashland_%s"):format(defaultKey), function(source, args)
        if(not (canUse)) then
            return
        end
        action(source)
    end)
    --[[
    RegisterCommand(("-flashland_%s"):format(defaultKey), function(source, args)
    end)
    --]]
    RegisterKeyMapping(("+flashland_%s"):format(defaultKey), desc, "keyboard", defaultKey)
end

_FlashLand.onReceiveWithoutNet("nowPlaying", function()
    canUse = true
end)
