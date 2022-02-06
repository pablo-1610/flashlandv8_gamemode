--[[
  This file is part of FlashLand.
  Created at 06/02/2022 11:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.retrievePlayerOrganisation = function(flashId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_players_organisation WHERE flashId = @flashId", {
        ["@flashId"] = flashId
    }, function(result)
        if (result[1]) then
            cb(result[1].orga, result[1].orga_grade)
        else
            _FlashServer_Database.insert("INSERT INTO flash_players_organisation (flashId, orga, orga_grade) VALUES (@flashId, @orga, @orga_grade)", {
                ["flashId"] = flashId,
                ["orga"] = _ConfigServer.Start.organisation,
                ["orga_grade"] = "citoyen",
            })
            cb(_ConfigServer.Start.organisation, nil)
        end
    end)
end