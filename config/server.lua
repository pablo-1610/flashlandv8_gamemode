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
        baseTime = { 21, 00 },
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

    Shops = {
        list = {
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(26.85, -1346.81, 29.49), npc = vector3(24.30, -1346.89, 29.49), npcHeading = 269.0 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(374.77, 326.44, 103.56), npc = vector3(372.66, 327.11, 103.56), npcHeading = 259.0 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(2556.56, 382.84, 108.62), npc = vector3(2556.70, 380.61, 108.62), npcHeading = 358.30 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-3040.09, 586.33, 7.90), npc = vector3(-3039.46, 584.17, 7.90), npcHeading = 17.0 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-3242.78, 1002.22, 12.83), npc = vector3(-3242.95, 999.87, 12.83), npcHeading = 351.46 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(547.15, 2670.44, 42.15), npc = vector3(549.37, 2670.79, 42.15), npcHeading = 99.73 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(1961.64, 3741.64, 32.34), npc = vector3(1959.68, 3740.35, 32.34), npcHeading = 310.0 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(2678.62, 3281.56, 55.24), npc = vector3(2677.38, 3279.54, 55.24), npcHeading = 331.0 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(1730.12, 6414.67, 35.03), npc = vector3(1727.86, 6415.66, 35.03), npcHeading = 246.72 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(1136.57, -982.00, 46.41), npc = vector3(1133.96, -981.74, 46.41), npcHeading = 280.25 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(-1223.72, -906.34, 12.32), npc = vector3(-1222.27, -908.85, 12.32), npcHeading = 35.21 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-1487.71, -379.96, 40.16), npc = vector3(-1485.87, -377.87, 40.16), npcHeading = 133.73 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-2968.72, 390.25, 15.04), npc = vector3(-2966.14, 390.36, 15.04), npcHeading = 83.13 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(1166.76, 2708.43, 38.15), npc = vector3(1166.44, 2711.02, 38.15), npcHeading = 186.32 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(1392.79, 3604.02, 34.98), npc = vector3(1392.16, 3606.24, 34.98), npcHeading = 200.0 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(-48.37, -1756.90, 29.42), npc = vector3(-46.52, -1758.61, 29.42), npcHeading = 48.57 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(1162.77, -323.43, 69.20), npc = vector3(1165.11, -322.50, 69.20), npcHeading = 102.76 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-708.11, -913.71, 19.21), npc = vector3(-705.53, -913.39, 19.21), npcHeading = 88.41 },
            { type = _FlashEnum_SHOPTYPE.ELEVEN, loc = vector3(-1821.52, 792.69, 138.12), npc = vector3(-1819.71, 794.33, 138.08), npcHeading = 131.73 },
            { type = _FlashEnum_SHOPTYPE.LTD, loc = vector3(1699.34, 4924.60, 42.06), npc = vector3(1698.07, 4922.35, 42.06), npcHeading = 326.17 },
        },

        categories = {
            {
                label = "Nourriture",
                content = {
                    { item = "pain", price = 1.50, fidelityPoints = 1 }
                }
            },

            {
                label = "Boissons",
                content = {
                    { item = "water", price = 2.50, fidelityPoints = 1 }
                }
            }
        }
    },

    Banks = {
        pedModel = "a_f_y_business_02",
        list = {
            { position = vector3(150.05, -1040.09, 29.37), npcPos = vector3(149.36, -1042.44, 29.36), npcHeading = 341.03, rob = vector3(146.81, -1044.86, 29.37) },
            { position = vector3(314.54, -278.030, 54.15), npcPos = vector3(313.62, -280.81, 54.15), npcHeading = 340.15, rob = vector3(310.62, -283.09, 54.16) },
            { position = vector3(-2963.88, 482.95, 15.68), npcPos = vector3(-2960.86, 482.94, 15.68), npcHeading = 87.87, rob = vector3(-2957.82, 480.80, 15.69) },
            { position = vector3(-1212.99, -330.0, 37.77), npcPos = vector3(-1211.7, -332.36, 37.77), npcHeading = 19.84, rob = vector3(-1212.01, -335.91, 37.79) },
            { position = vector3(-350.7, -49.09, 49.03), npcPos = vector3(-351.47, -51.76, 49.03), npcHeading = 342.99, rob = vector3(-354.03, -54.08, 49.04) },
            { position = vector3(1175.04, 2705.88, 38.09), npcPos = vector3(1174.92, 2708.7, 38.08), npcHeading = 175.75, rob = vector3(1176.91, 2711.76, 38.09) },
            -- Paleto bank
            { position = vector3(-113.79, 6469.42, 31.62), npcPos = vector3(-111.96, 6471.34, 31.62), npcHeading = 133.23 }
        },

        guards = {
            { position = vector3(152.36, -1038.65, 29.36), heading = 163.96 },
            { position = vector3(313.05493164062, -275.80218505859, 54.150146484375), heading = 158.74015808105 },
            { position = vector3(-2965.38, 484.66, 15.68), heading = 269.29 },
            { position = vector3(-1212.51, -327.51, 37.77), heading = 212.6 },
            { position = vector3(-348.53, -47.7, 49.03), heading = 161.57 },
            { position = vector3(1173.43, 2703.92, 38.08), heading = 0.0 },
            -- Paleto bank
            { position = vector3(-111.59, 6464.48, 31.62), heading = 317.48 },
            { position = vector3(-100.46, 6463.24, 31.62), heading = 130.39 },
            { position = vector3(-105.4, 6470.81, 31.62), heading = 136.06, scenario = "WORLD_HUMAN_CLIPBOARD" }


        }
    },

    NationalBank = {
        accountCreationPrice = 500,

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
            { position = vector3(259.40, 215.93, 106.28), heading = 74.89 },
            { position = vector3(232.91, 220.11, 106.28), heading = 255.54 },
            { position = vector3(237.56, 217.80, 110.28), heading = 296.28 }
        }
    },

    TattooShop = {
        list = {
            { position = vector3(1321.73, -1653.59, 52.27), npcPosition = vector3(1324.70, -1650.07, 52.27), npcHeading = 128.66 },
            { position = vector3(324.23, 180.31, 103.58), npcPosition = vector3(319.65, 181.01, 103.58), npcHeading = 247.66 },
            { position = vector3(-1155.22, -1427.03, 4.95), npcPosition = vector3(-1152.00, -1423.79, 4.95), npcHeading = 123.98 },
            { position = vector3(-3169.54, 1077.47, 20.82), npcPosition = vector3(-3170.69, 1072.96, 20.82), npcHeading = 335.63 },
            { position = vector3(1864.92, 3746.97, 33.03), npcPosition = vector3(1862.87, 3748.18, 33.03), npcHeading = 28.20 },
            { position = vector3(-294.48, 6200.48, 31.48), npcPosition = vector3(-292.37, 6199.75, 31.48), npcHeading = 221.87 },
        }
    },

    BarberShop = {
        price = 150,
        list = {
            { position = vector3(-278.40, 6226.84, 31.75), npcPosition = vector3(-277.88, 6230.32, 31.69), npcHeading = 47.93, npc = nil, seat = {pos = vector3(-279.50, 6226.89, 31.50), heading = 130.39, status = false}},
            { position = vector3(1932.25, 3731.42, 32.85), npcPosition = vector3(1930.81, 3728.31, 32.84), npcHeading = 210.73, npc = nil, seat = {pos = vector3(1933.28, 3731.11, 32.70), heading = 301.14, status = false}},
            { position = vector3(1212.85, -473.97, 66.21), npcPosition = vector3(1211.64, -470.72, 66.20), npcHeading = 73.73, npc = nil, seat = {pos = vector3(67.12, -474.64, 67.12), heading = 167.24, status = false}},
            { position = vector3(-34.24, -152.72, 57.08), npcPosition = vector3(-30.97, -151.77, 57.07), npcHeading = 334.94, npc = nil, seat = {pos = vector3(58.00, -151.76, 58), heading = 68.03, status = false}},
            { position = vector3(-815.11, -182.86, 37.56), npcPosition = vector3(-821.96, -183.12, 37.56), npcHeading = 208.65, npc = nil, seat = {pos = vector3(38.14, -182.94, 38.14), heading = 31.18, status = false}},
            { position = vector3(-1282.08, -1118.30, 7.00), npcPosition = vector3(-1284.03, -1115.62, 6.99), npcHeading = 87.15, npc = nil, seat = {pos = vector3(7.96, -1119.08, 7.96), heading = 175.74, status = false}},
            { position = vector3(138.32, -1708.28, 29.30), npcPosition = vector3(134.79, -1707.86, 29.29), npcHeading = 139.65, npc = nil, seat = {pos = vector3(-279.50, 6226.89, 31.50), heading = 130.39, status = false}},
        },
    },

    Ammunation = {
        list = {
            { position = vector3(-278.40, 6226.84, 31.75), npcPosition = vector3(-278.40, 6226.84, 31.75), npcHeading = 180.0, npc = nil }
        },
    },

    RichPresence = {
        appId = "830843275950424125",
    }
}