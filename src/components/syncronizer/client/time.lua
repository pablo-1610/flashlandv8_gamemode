--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:54
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local overrideTime

local function setTime(timeTable)
    local h, m = timeTable[1], timeTable[2]
    NetworkOverrideClockTime(h, m, 00)
end

_FlashClient_Synchronizer.destroyTimeOverride = function()
    overrideTime = nil
    _FlashLand.toServer("synchronizer:getTime")
end

_FlashClient_Synchronizer.setTimeOverride = function(timeTable)
    overrideTime = timeTable
    setTime(timeTable)
end

_FlashLand.onReceiveWithoutNet("joined", function()
    _FlashLand.toServer("synchronizer:getTime")
end)

_FlashLand.onReceive("synchronizer:setTime", function(timeTable)
    if (overrideTime ~= nil) then
        return
    end
    setTime(timeTable)
end)