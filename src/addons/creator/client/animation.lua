--[[
  This file is part of FlashLand.
  Created at 28/10/2021 15:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("creator:playAnimation", function(spawn)
    -- TODO -> Animation when character is done
    local animation = true
    _FlashClient_Utils.memory_loadDict("flashland")
    print("ok")
    SwitchOutPlayer(PlayerPedId(), 0, 1)
    _FlashClient_Utils.drawer_spriteWithSmooth(function()
       return (animation)
    end, "flashland", "logo_transparent", 0.5, 0.5, 10.0, 10.0, 0.0)
end)