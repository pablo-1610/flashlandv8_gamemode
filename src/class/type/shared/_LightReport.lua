--[[
  This file is part of FlashLand.
  Created at 03/01/2022 16:46
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---@class _LightReport
---@field public source number
---@field public name string
---@field public reason string
---@field public date string
---@field public status number
---@field public moderatorId number
---@field public moderator string
_LightReport = {}
_LightReport.__index = _LightReport

setmetatable(_LightReport, {
    __call = function(_, sId, name, reason, date, status, moderatorId, moderator)
        local self = setmetatable({}, _LightReport)
        self.sId = sId
        self.name = name
        self.reason = reason
        self.date = date
        self.status = status or 0
        self.moderatorId = moderatorId or nil
        self.moderator = moderator or nil
        return (self)
    end
})