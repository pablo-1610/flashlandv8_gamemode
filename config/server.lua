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
        loadoutCapacity = 3.0
    },

    Citizens = {
        lockdown = true,
    },

    Synchronizer = {
        baseTime = {21,00},
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

    NationalBank = {
        pedModel = "a_m_y_business_02",
        desks = {
            {
                position = vector3(241.01, 223.78, 106.28),
                ped = {
                    position = vector3(241.91, 227.13, 106.28),
                    heading = 158.89
                }
            },

            {
                position = vector3(245.96, 221.79, 106.28),
                ped = {
                    position = vector3(247.17, 225.40, 106.26),
                    heading = 158.89
                }
            },

            {
                position = vector3(251.23, 219.80, 106.28),
                ped = {
                    position = vector3(252.280, 223.61, 106.28),
                    heading = 158.89
                }
            }
        },

        guards = {
            {position = vector3(259.40, 215.93, 106.28), heading = 74.89},
            {position = vector3(232.91, 220.11, 106.28), heading = 255.54},
            {position = vector3(237.56, 217.80, 110.28), heading = 296.28}
        }
    },

    RichPresence = {
        appId = "830843275950424125",
    }
}