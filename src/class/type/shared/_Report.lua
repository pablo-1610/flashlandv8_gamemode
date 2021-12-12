--[[
  This file is part of FlashLand.
  Created at 10/12/2021 18:33
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---
---@class _Report
---@field public source number
---@field public name string
---@field public reason string
---@field public date string
---@field public status number
---@field public moderator string
_Report = {}
_Report.__index = _Report

setmetatable(_Report, {
    __call = function(_, sId, name, reason, status, moderator)
        local self = setmetatable({}, _Report)
        self.sId = sId
        self.name = name
        self.reason = reason
        self.date = _FlashUtils.setHour()
        self.status = status or 0
        self.moderator = moderator or nil
        return self
    end
})

---getPlayerName
---@public
---@return string
function _Report:getPlayerName()
    return (self.name)
end

---getStaffName
---@public
---@return string
function _Report:getStaffName()
    return (self.moderator)
end

---updateStatus
---@public
---@return void
function _Report:updateStatus()
    self.status = 1
end

---setModerator
---@public
---@return void
function _Report:setModerator(name)
    self.moderator = name
end