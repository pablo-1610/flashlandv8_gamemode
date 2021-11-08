--[[
  This file is part of FlashLand.
  Created at 28/10/2021 16:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Warden
_FlashServer_Warden = {}

local function actionBySeverity(_src, violation)
    local severity = violation.severity
    if (severity == _FlashEnum_WARDENSEVERITY.LOW) then
        -- TODO -> Low severity
    elseif (severity == _FlashEnum_WARDENSEVERITY.MED) then
        -- TODO -> Med severity
    elseif (severity == _FlashEnum_WARDENSEVERITY.HIGH) then
        _FlashServer_Warden.kick(_src, violation.code)
    end
end

_FlashServer_Warden.kick = function(_src, code)
    _FlashServer_Players.kick(_src, "Warden (Anti-Cheat)", ("Code %s"):format(code))
end

_FlashServer_Warden.getPrefix = function()
    return ("{WARDEN}")
end

_FlashServer_Warden.violation = function(_src, violation)
    actionBySeverity(_src, violation)
end

_FlashLand.loadedComponent("warden")