--[[
  This file is part of FlashLand.
  Created at 05/01/2022 17:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param ban _Ban
_FlashServer_Bans.getLightBan = function(banIdentifier)
    ---@type _LightBan
    local ban = _FlashServer_Bans.get(banIdentifier)
    return (_LightBan(ban.identifier, ban.flashId, ban.name, ban.moderator, ban.date, ban.reason, ban.status))
end