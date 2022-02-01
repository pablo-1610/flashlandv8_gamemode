--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Job:registerJob("police", "Police")
                :setMetadata(_FlashEnum_JOBMETADATA.PUBLIC_BLIP, {
    {
        position = vector3(440.74, -982.77, 30.68),
        name = "Poste de police",
        color = 29,
        sprite = 60,
        shortRange = true,
    }
})
                :setMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS, {
    zones = {
        {
            garageMenu = {
                vector3(458.63, -1008.00, 28.27)
            },
            backZones = {
                vector3(462.93, -1019.74, 28.10),
                vector3(463.03, -1014.62, 28.06)
            },
            outPossibilities = {
                vector3(446.24, -1025.54, 28.640),
                vector3(434.87, -1026.97, 29.85),
            },
            outHeading = 6.65,
        },
    },
    defaultVehicles = {
        { "policeb", "Moto de police" }
    }
})
                :setMetadata(_FlashEnum_JOBMETADATA.STATIC_PED, {
    { uniqueId = "garagePed", model = "s_m_y_cop_01", scenario = "WORLD_HUMAN_CLIPBOARD", position = vector3(457.29, -1007.005, 28.29), heading = 180.34 },
})
                :setMetadata(_FlashEnum_JOBMETADATA.CLOAKROOM_INFO, {
    zones = {
        vector3(450.89, -992.47, 30.68),
    },
    defaultValues = {
        grades = {
            ["boss"] = {
                ["helmet_1"] = 45
            }
        },
        additional = {
            {
                label = "Tenue d'intervention",
                outfit = {

                },
                grades = {
                    "boss"
                }
            }
        }
    }
})
                :setMetadata(_FlashEnum_JOBMETADATA.BOSS_INFOS, {
    zones = {
        vector3(448.26, -973.02, 30.68)
    }
})
                :setMetadata(_FlashEnum_JOBMETADATA.LOCAL_DATA, {
    { id = "plaintes" }
})
                :setMetadata(_FlashEnum_JOBMETADATA.ARMORY_INFOS, {
    weapons = {
        "WEAPON_PISTOL"
    },
    zones = {
        vector3(451.79, -980.13, 30.68)
    }
})
