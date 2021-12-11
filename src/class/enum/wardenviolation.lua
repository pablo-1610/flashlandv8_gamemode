--[[
  This file is part of FlashLand.
  Created at 25/10/2021 12:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashEnum_WARDENVIOLATION = {
    USER_DUPLICATION = { code = 200, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    INVENTORY_NO_ITEM = { code = 201, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    TARGET_NO_EXISTS = { code = 202, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    DENIED_ADMIN_PERMISSION = { code = 203, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    ZONE_INTERACTION_NOT_ALLOWED = { code = 204, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    PLAYER_NOT_EXISTS = { code = 205, severity = _FlashEnum_WARDENSEVERITY.LOW },

    ZONE_NOT_EXISTS = { code = 206, severity = _FlashEnum_WARDENSEVERITY.HIGH },
    ZONE_TOO_FAR = { code = 207, severity = _FlashEnum_WARDENSEVERITY.HIGH },
}