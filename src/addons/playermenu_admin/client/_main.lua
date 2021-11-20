--[[
  This file is part of FlashLand.
  Created at 10/11/2021 00:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_Staff
_FlashClient_Staff = {}

local active = false
local playerList = {}
local selectedPlayer = {}

_FlashClient_Staff.backIfNotActive = function()
    print(json.encode(active))
    if (not (active)) then
        RageUI.GoBack()
    end
end

_FlashClient_Staff.getSelectedPlayer = function()
    return (selectedPlayer)
end

_FlashClient_Staff.setSelectedPlayer = function(playerId)
    selectedPlayer = playerId
end

_FlashClient_Staff.isCurrentActive = function()
    return (active)
end

_FlashClient_Staff.setCurrentActive = function(checked)
    active = checked
end

_FlashClient_Staff.playerListExists = function(_src)
    return (playerList[_src] ~= nil)
end

_FlashClient_Staff.getPlayerList = function()
    return (playerList)
end

_FlashLand.onReceive("staff:cbPlayerList", function(lightPlayers)
    for k, lightPlayer in pairs(lightPlayers) do
        lightPlayer.rank = _Rank(lightPlayer.rank.id, lightPlayer.rank.label, lightPlayer.rank.weight, lightPlayer.rank.permissions, lightPlayer.rank.baseColor)
        lightPlayer.inventory = _LightInventory(lightPlayer.inventory.id, lightPlayer.inventory.type, lightPlayer.inventory.label, lightPlayer.inventory.capacity, lightPlayer.inventory.content)
    end
    playerList = lightPlayers
end)