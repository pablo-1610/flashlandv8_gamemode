--[[
  This file is part of FlashLand.
  Created at 19/01/2022 22:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.deleteOrganisation = function(organisationName, callback)
    if (not (_FlashServer_Organisation.exist(organisationName))) then
        return (callback(false))
    end
    ---@type _Orga
    local orga = _FlashServer_Organisation.get(organisationName)
    orga:deleteAllInteractions()
    _FlashServer_Database.execute("DELETE FROM flash_orga WHERE name = @name", {
        ["name"] = organisationName
    })
    _FlashServer_Database.execute("DELETE FROM flash_orga_grades WHERE orgaId = @orgaId", {
        ["orgaId"] = organisationName
    })
    _FlashServer_Database.execute("DELETE FROM flash_orga_grades_permissions WHERE orga_name = @orga_name", {
        ["orga_name"] = organisationName
    })
    _FlashServer_Organisation.remove(organisationName)
    callback(true)
end