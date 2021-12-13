--[[
  This file is part of FlashLand.
  Created at 12/12/2021 18:46
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

for bankId, bankData in pairs(_ConfigServer.Banks.list) do
    if (not (bankData.rob)) then
        goto continue
    end
    -- Zones
    ---@type _Zone
    local rob = _FlashServer_Zones.createPublic(bankData.rob, { 255, 0, 0 }, function(_src, player, lightZone)
        _FlashLand.toInternal("bankRobbery:openMenu", _src, bankId)
    end, "Appuyez sur ~INPUT_CONTEXT~ pour inspecter la sécurité", 20.0, 1.0, true)

    -- Blips
    local blip = _FlashServer_Blips.createPublicInArea(bankData.rob, 648, 59, _Config.genericSubBlipSize, "Coffre de la banque", true, 10.0)
    :: continue ::
end