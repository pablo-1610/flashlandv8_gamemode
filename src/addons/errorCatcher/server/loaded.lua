--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:27
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    local reportFile = ("resources/flashland/error/%s.log"):format(_Environment.serverVer)
    if (not (_FlashServer_Utils.file_exists(reportFile))) then
        _FlashLand.log("Creation du fichier log")
        _FlashServer_Utils.file_write(reportFile, "Création automatique du fichier log pour la version.")
    end
end)