--[[
  This file is part of FlashLand.
  Created at 11/01/2022 20:50
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY
---@class _LightOrga
_LightOrga = {}
_LightOrga.__index = _LightOrga

setmetatable(_LightOrga, {
    __call = function(_, jobName, jobLabel, grades, bossPos, safePos, spawnVehiclePos, delVehiclePos, blip, allowed)
        local self = setmetatable({}, _LightOrga)
        self.jobName = jobName
        self.jobLabel = jobLabel
        self.grades = grades
        self.bossPos = bossPos
        self.safePos = safePos
        self.spawnVehiclePos = spawnVehiclePos
        self.delVehiclePos = delVehiclePos
        self.blip = blip
        self.allowed = allowed
        return (self)
    end
})