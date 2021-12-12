--[[
  This file is part of FlashLand.
  Created at 11/12/2021 23:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Shops
_FlashServer_Shops = {}

local function getInverseHeading(heading)
    return (heading + 180) % 360
end

for shopId, shop in pairs(_ConfigServer.Shops.list) do
    local type = _FlashEnum_SHOPTYPEDATA[shop.type]
    ---@type _Blip
    local blip = _FlashServer_Blips.createPublic(shop.loc, 59, 69, _Config.genericBlipSize, "Superette", true)

    ---@type _Npc
    local npc = _FlashServer_Npc.create(shop.npc, shop.npcHeading, "mp_m_shopkeep_01", false, true, 50.0)
    npc:setScenario("WORLD_HUMAN_CLIPBOARD_FACILITY", true)

    if (_Config.environment == _FlashEnum_ENV.DEV) then
        npc:setName(("[DEBUG] SHOPID %s"):format(shopId), 0, 10.0)
    end

    ---@type _Zone
    local zone = _FlashServer_Zones.createPublic(shop.loc, { 255, 255, 255 }, function(_src, player)
        _FlashLand.toInternal("shop:openShopMenu", _src, shopId, shop.type, npc.id)
    end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir parler au vendeur", 20.0, 1.0, true, getInverseHeading(shop.npcHeading))
end