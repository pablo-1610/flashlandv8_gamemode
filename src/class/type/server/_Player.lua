--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Player
_Player = {}
_Player.__index = _Player

setmetatable(_Player, {
    __call = function(_)
        local self = setmetatable({}, _Player)

    end
})