--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_Config = {
    prefix = "[^6FlashLand^7]",
    environment = "PROD",
    enableErrorsLog = true,
    enableSqlLog = false,
    startRank = "member",

    genericBlipSize = 1.0,
    genericSubBlipSize = 0.7,

    Staff = {
        permissions = {
            ["open"] = "admin.open",
            ["noclip"] = "admin.noclip",
        }
    },

    Color = {
        { name = "Rouge", color = "~r~" },
        { name = "Bleu", color = "~b~" },
        { name = "Vert", color = "~g~" },
        { name = "Jaune", color = "~y~" },
        { name = "Violet", color = "~p~" },
        { name = "Gris Clair", color = "~c~" },
        { name = "Gris Foncé", color = "~m~" },
        { name = "Noir", color = "~u~" },
        { name = "Orange", color = "~o~" },
    },
}