--[[
  This file is part of FlashLand.
  Created at 28/10/2021 15:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("creator:sendData", function(creatorData)
    local _src = source
    local skin, identity, outfit = creatorData.skin, creatorData.identity, creatorData.outfit
    if (_FlashServer_Players.exists(_src) or _FlashServer_Players.existsInDb(_src)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.USER_DUPLICATION)
        return
    end
    -- TODO -> Create player in db
    -- TODO -> Add a _Player in the Players server cache
    -- TODO -> Send back infos (cache)
    -- TODO -> Set playing state
end)