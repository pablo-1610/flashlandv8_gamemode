--[[
  This file is part of FlashLand.
  Created at 11/01/2022 21:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@param player _Player
_FlashClient_PlayerMenu.drawer[21] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedOrganisation ~= nil) then
        local organisations = _FlashClient_Staff.getOrganisationList()
        local organisationData = organisations[_FlashClient_PlayerMenu.var.selectedOrganisation]

    end
end