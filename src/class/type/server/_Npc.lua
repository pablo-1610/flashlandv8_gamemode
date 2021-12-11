--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Npc
---@field public id number
---@field public position table
---@field public heading number
---@field public model string
---@field public ai boolean
---@field public frozen boolean
---@field public drawDist number
---@field public subscribed table
---@field public scenario table
---@field public name table
---@field public fakeWeapon string
_Npc = {}
_Npc.__index = _Npc

setmetatable(_Npc, {
    __call = function(_, id, position, heading, model, ai, frozen, drawDist)
        local self = setmetatable({}, _Npc)
        self.id = id
        self.position = vector3(position.x, position.y, (position.z - 1.0))
        self.heading = heading
        self.model = model
        self.ai = ai
        self.frozen = frozen
        self.drawDist = drawDist
        self.subscribed = {}
        return (self)
    end
})

function _Npc:setName(name, color, drawDist)
    self.name = { label = name, color = color, drawDist = drawDist }
end

function _Npc:setScenario(scenario, instantly)
    self.scenario = {
        name = scenario,
        instantly = instantly
    }
    for _, _src in pairs(self.subscribed) do
        _FlashLand.toClient("npc:updateScenario", _src, self.id, self.scenario)
    end
end

function _Npc:setFakeWeapon(weapon)
    self.fakeWeapon = weapon
end

function _Npc:getVisualData()
    return ({ name = self.name, scenario = self.scenario, weapon = self.fakeWeapon })
end

function _Npc:getLightNpc()
    return (_LightNpc(self.id, self.position, self.heading, self.model, self.ai, self.frozen, self:getVisualData()))
end

function _Npc:say(speech, param, _src)
    if (self:isSubscribed(_src)) then
        _FlashLand.toClient("npc:say", _src, self.id, speech, param)
    end
end

function _Npc:sayForAll(speech, param)
    for _, _src in pairs(self.subscribed) do
        _FlashLand.toClient("npc:say", _src, self.id, speech, param)
    end
end

function _Npc:isSubscribed(_src)
    for _, v in pairs(self.subscribed) do
        if v == _src then
            return (true)
        end
    end
    return (false)
end

function _Npc:subscribe(_src)
    if (not (self:isSubscribed(_src))) then
        table.insert(self.subscribed, _src)
        _FlashLand.toClient("npc:subscribe", _src, self:getLightNpc())
    end
end

function _Npc:unsubscribe(_src, doNotSendEvent)
    for i, v in pairs(self.subscribed) do
        if (v == _src) then
            table.remove(self.subscribed, i)
            if (not (doNotSendEvent)) then
                _FlashLand.toClient("npc:unsubscribe", _src, self.id)
            end
            break
        end
    end
end