--[[
  This file is part of FlashLand.
  Created at 03/01/2022 16:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---@class _LightBan
---@field public identifier string
---@field public flashId number
---@field public identity table
---@field moderator flashId string
---@field date flashId string
---@field reason flashId string
_LightBan = {}
_LightBan.__index = _LightBan

setmetatable(_LightBan, {
    __call = function(_, identifier, flashId, name, moderator, date, reason)
        local self = setmetatable({}, _LightBan)
        self.identifier = identifier
        self.flashId = flashId
        self.name = name
        self.moderator = moderator
        self.date = date
        self.reason = reason
        return (self)
    end
})