--[[
  This file is part of FlashLand.
  Created at 09/12/2021 19:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightZone
---@field public id number
---@field public location table
---@field public color table
---@field public helpText string
---@field public itrDist number
_LightZone = {}
_LightZone.__index = _LightZone

setmetatable(_LightZone, {
    __call = function(_, id, location, color, helpText, itrDist)
        local self = setmetatable({}, _LightZone)
        self.id = id
        self.location = location
        self.color = color
        self.helpText = helpText
        self.itrDist = itrDist
        return (self)
    end
})

function _LightZone:canInteract(position)
    return (#(self.location - position) < self.itrDist)
end

function _LightZone:sendHelpMessage()
    _FlashClient_Utils.notifications_showHelp(self.helpText or "Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
end

function _LightZone:interact()
    _FlashLand.toServer("zone:interact", self.id)
end

function _LightZone:draw()
    DrawMarker(25, self.location.x, self.location.y, (self.location.z - 0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, self.color[1], self.color[2], self.color[3], 100, false, true, 2, false, false, false, false)
end