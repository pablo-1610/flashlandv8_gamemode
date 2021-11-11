--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:11
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_ConfigServer = {
    Start = {
        startPosition = { coords = vector3(-221.74, -1053.19, 30.13), heading = 164.00 },
        rank = "member",
        cash = (1500),
        bagCapacity = 10.0,
    },

    Citizens = {
        lockdown = false,
    },

    Synchronizer = {
        baseTime = {12,00},
        time = (30000),
        weather = (60000 * 60),
        position = (60000),
    },

    Logs = {
        join = "",
        left = "",
        new = "",
        warden = "",
    },

    RichPresence = {
        appId = "830843275950424125",
    }
}