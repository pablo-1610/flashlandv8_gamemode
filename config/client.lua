--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_ConfigClient = {
    Creator = {
        pedPosition = {coords = vector3(686.25, 577.69, 130.46), heading = 164.0},
        camPosition = {coords = vector3(683.78, 570.56, 130.46)},

        defaultOutFits = {
            {
                label = "Urbain",
                values = {
                    [0] = {
                        ["mask_1"] = 40,
                        ["mask_2"] = 1
                    }
                }
            }
        }
    },

    Skin = {
        {id = "skin", label = "Peau"},
        {id = "face", label = "Visage"},
        {id = "hair_1", label = "Cheveux", sub = "hair_color_1"},
        {id = "beard_2", label = "Taille barbe"},
        {id = "beard_1", label = "Type barbe", sub = "beard_3"}
    }
}