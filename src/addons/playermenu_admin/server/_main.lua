--[[
  This file is part of FlashLand.
  Created at 16/11/2021 23:31
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Staff
_FlashServer_Staff = {}

local activeStaff = {}

_FlashServer_Staff.isActive = function(_src)
    for id, _ in pairs(activeStaff) do
        if (id == _src) then
            return true
        end
    end
    return false
end

_FlashServer_Staff.addActive = function(_src)
    if (_FlashServer_Staff.isActive(_src)) then
        _FlashLand.err(("addActive deja active (%s)"):format(_src))
        return
    end
    activeStaff[_src] = true
end

_FlashServer_Staff.removeFromActives = function(_src)
    if (not (_FlashServer_Staff.isActive(_src))) then
        _FlashLand.err(("removeFromActives pas active (%s)"):format(_src))
        return
    end
    activeStaff[_src] = nil
end

-- TODO → Update when a player join or left
_FlashServer_Staff.updatePlayersForStaff = function()
    for _src, _ in pairs(activeStaff) do
        _FlashLand.toClient("staff:cbPlayerList", _src, _FlashServer_Staff.generateAllLightPlayers())
    end
end

_FlashServer_Staff.generateAllLightPlayers = function()
    local players = {}
    for _src, _ in pairs(_FlashServer_Players.getAll()) do
        players[_src] = _FlashServer_Players.getLightPlayer(_src)
    end
    return (players)
end

_FlashLand.onReceiveExposed("justDebug", function(string)
    _FlashLand.errLog(string)
end)