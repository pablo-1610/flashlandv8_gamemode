--[[
  This file is part of FlashLand.
  Created at 03/01/2022 16:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---@class _Ban
---@field public identifier string
---@field public name string
---@field public date string
---@field public time string
---@field public reason string
---@field public moderator string
_Ban = {}
_Ban.__index = {}

setmetatable(_Ban, {
    __call = function(_, identifier, name, date, time, reason, moderator)
        local self = setmetatable({}, _Ban)
        self.identifier = identifier
        self.name = name
        self.date = date
        self.time = time
        self.reason = reason
        self.moderator = moderator
        return (self)
    end
})