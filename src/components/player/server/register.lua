--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Players.register = function(_src, infos)
    local outfits = { ["Tenue d'arrivée"] = infos.outfit }
    local license = _FlashServer_Utils.identifiers_get(_src, "license")
    _FlashServer_Database.insert("INSERT INTO flash_players (identifier, rankId, identity, cash, skin, outfits, selectedOutfit, accessories) VALUES(@identifier, @rankId, @identity, @cash, @skin, @outfits, @selectedOutfit, @accessories)", {
        ["identifier"] = license,
        ["rankId"] = _ConfigServer.Start.rank,
        ["identity"] = json.encode(infos.identity),
        ["cash"] = _ConfigServer.Start.cash,
        ["skin"] = json.encode(infos.skin),
        ["outfits"] = json.encode(outfits),
        ["selectedOutfit"] = "Tenue d'arrivée",
        ["accessories"] = json.encode({})
    }, function(flashId)
        ---@type _Player
        local player = _Player(_src, flashId, license, _ConfigServer.Start.rank, infos.identity, _ConfigServer.Start.cash, infos.skin, outfits, "Tenue d'arrivée", {})
        print(json.encode(player.identity))
        _FlashServer_Players.add(player)
        _FlashLand.toInternal("creator:playerRegistered", _src)
        -- TODO -> Send back infos
        _FlashServer_Database.insert("INSERT INTO flash_players_positions (flashId, position) VALUES(@flashId, @position)", {
            ["flashId"] = flashId,
            ["position"] = json.encode(_ConfigServer.Start.startPosition)
        })
        _FlashServer_Database.insert("INSERT INTO flash_players_identifiers (flashId, license, steam, live, xbl, discord, endpoint) VALUES(@flashId, @license, @steam, @live, @xbl, @discord, @endpoint)", {
            ["flashId"] = flashId,
            ["license"] = _FlashServer_Utils.identifiers_get(_src, "license"),
            ["steam"] = _FlashServer_Utils.identifiers_get(_src, "steam"),
            ["live"] = _FlashServer_Utils.identifiers_get(_src, "live"),
            ["xbl"] = _FlashServer_Utils.identifiers_get(_src, "xbl"),
            ["discord"] = _FlashServer_Utils.identifiers_get(_src, "discord"),
            ["endpoint"] = _FlashServer_Utils.identifiers_get(_src, "ip")
        })
    end)
end