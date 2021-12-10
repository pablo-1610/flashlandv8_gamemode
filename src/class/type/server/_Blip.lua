--[[
  This file is part of FlashLand.
  Created at 10/12/2021 16:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Blip
---@field public id number
---@field public position table
---@field public sprite number
---@field public color number
---@field public size number
---@field public shortRange boolean
---@field public drawDist number
---@field public restricted boolean
---@field public subscribed table
---@field public allowed table
_Blip = {}
_Blip.__index = _Blip

setmetatable(_Blip, {
    __call = function(_, id, position, sprite, color, size, shortRange, drawDist, restricted)
        local self = setmetatable({}, _Blip)
        self.id = id
        self.position = position
        self.sprite = sprite
        self.color = color
        self.size = size
        self.shortRange = shortRange
        self.drawDist = drawDist
        self.restricted = restricted
        self.subscribed = {}
        self.allowed = {}
        return (self)
    end
})

function _Blip:isSubscribed(_src)
    for _, v in pairs(self.subscribed) do
        if (v == _src) then
            return (true)
        end
    end
    return (false)
end

function _Blip:isAllowed(_src)
    for _, v in pairs(self.allowed) do
        if v == _src then
            return (true)
        end
    end
    return (false)
end

function _Blip:subscribe(_src)
    if (not (self:isSubscribed(_src))) then
        table.insert(self.subscribed, _src)
        _FlashLand.toClient("blip:subscribe", _src, self:getLightBlip())
    end
end

function _Blip:unsubscribe(_src, doNotSendEvent)
    for i, v in pairs(self.subscribed) do
        if (v == _src) then
            table.remove(self.subscribed, i)
            if (not (doNotSendEvent)) then
                _FlashLand.toClient("blip:unsubscribe", _src, self.id)
            end
            break
        end
    end
end

function _Blip:addAllow(_src)
    if (not (self:isAllowed(_src))) then
        table.insert(self.allowed, _src)
    end
end

function _Blip:removeAllowed(_src)
    for i, v in pairs(self.allowed) do
        if (v == _src) then
            table.remove(self.allowed, i)
        end
    end
end

function _Blip:isEverywhere()
    return (self.drawDist <= 0)
end