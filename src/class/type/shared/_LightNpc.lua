--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightNpc
---@field public id number
---@field public position table
---@field public heading number
---@field public model string
---@field public ai boolean
---@field public frozen boolean
---@field public visualData table
_LightNpc = {}
_LightNpc.__index = _LightNpc

setmetatable(_LightNpc, {
    __call = function(_, id, position, heading, model, ai, frozen, visualData)
        local self = setmetatable({}, _LightNpc)
        self.id = id
        self.position = position
        self.heading = heading
        self.model = model
        self.ai = ai
        self.frozen = frozen
        self.visualData = visualData
        return (self)
    end
})