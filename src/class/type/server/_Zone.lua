--[[
  This file is part of FlashLand.
  Created at 09/12/2021 19:42
  
  Copyright (c) FlashLand - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _Zone
---@field public id number
---@field public location table
---@field public color table
---@field public onInteract function
---@field public helpText function
---@field public drawDist number
---@field public itrDist number
---@field public restricted boolean
---@field public hideIfAMenuIsOpen boolean
---@field public headingCorrection number
---@field public subscribed table
---@field public allowed table
_Zone = {}
_Zone.__index = _Zone

setmetatable(_Zone, {
    __call = function(_, id, location, color, onInteract, helpText, drawDist, itrDist, restricted, hideIfAMenuIsOpen, headingCorrection, jobRequired)
        local self = setmetatable({}, _Zone)
        self.id = id
        self.location = location
        self.color = color
        self.onInteract = onInteract
        self.helpText = helpText
        self.drawDist = drawDist
        self.itrDist = itrDist
        self.restricted = restricted
        self.hideIfAMenuIsOpen = hideIfAMenuIsOpen
        self.headingCorrection = headingCorrection
        self.jobRequired = jobRequired
        self.subscribed = {}
        self.allowed = {}
        self.flags = {}
        return (self)
    end
})

function _Zone:hasFlag(flag)
    for _, v in pairs(self.flags) do
        if v == flag then
            return true
        end
    end
    return false
end

function _Zone:addFlag(flag)
    if (not (self:hasFlag(flag))) then
        table.insert(self.flags, flag)
    end
end

function _Zone:getLightZone()
    return (_LightZone(self.id, self.location, self.color, self.helpText, self.itrDist, self.hideIfAMenuIsOpen, self.headingCorrection))
end

function _Zone:isSubscribed(_src)
    for _, v in pairs(self.subscribed) do
        if (v == _src) then
            return (true)
        end
    end
    return (false)
end

function _Zone:isAllowed(_src)
    for _, v in pairs(self.allowed) do
        if v == _src then
            return (true)
        end
    end
    return (false)
end

function _Zone:subscribe(_src)
    if (not (self:isSubscribed(_src))) then
        table.insert(self.subscribed, _src)
        _FlashLand.toClient("zone:subscribe", _src, self:getLightZone())
    end
end

function _Zone:unsubscribe(_src, doNotSendEvent)
    for i, v in pairs(self.subscribed) do
        if (v == _src) then
            table.remove(self.subscribed, i)
            if (not (doNotSendEvent)) then
                _FlashLand.toClient("zone:unsubscribe", _src, self.id)
            end
            break
        end
    end
end

function _Zone:addAllow(_src)
    if (not (self:isAllowed(_src))) then
        table.insert(self.allowed, _src)
    end
end

function _Zone:removeAllowed(_src)
    for i, v in pairs(self.allowed) do
        if (v == _src) then
            table.remove(self.allowed, i)
        end
    end
end

function _Zone:interact(_src)
    -- Security related
    if (self.restricted) then
        if (not self:isAllowed(_src)) then
            _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ZONE_INTERACTION_NOT_ALLOWED)
            return
        end
    end
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    -- Interaction
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    CreateThread(function()
        _FlashServer_Webhooks.send(_Webhooks.ZONE_INTERACT, ("[%s] __%s__ (%s) a intéragit avec la zone **%s**"):format(player.rank.label, player.name, player.flashId, self.id))
    end)
    self.onInteract(_src, player, self:getLightZone())
end