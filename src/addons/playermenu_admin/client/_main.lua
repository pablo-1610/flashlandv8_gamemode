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
local reportList = {}
local banList = {}
local organisation = {}
local permission = {}
local rank = {}

_FlashClient_Staff.backIfNotActive = function()
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

_FlashClient_Utils.playerListExists = function(_src)
    return (playerList[_src] ~= nil)
end

_FlashClient_Staff.getPlayerList = function()
    return (playerList)
end

_FlashClient_Staff.getPermFromConfig = function(permission)
    return (_Config.Staff.permissions[permission])
end

_FlashClient_Staff.hasPermission = function(permission)
    ---@type _Player
    local player = _FlashClient_Cache.getPlayer()
    return (player.rank:hasPermission(permission))
end

_FlashClient_Staff.getReportList = function()
    return (reportList)
end

_FlashClient_Staff.getBanList = function()
    return (banList)
end

_FlashClient_Staff.getOrganisationList = function()
    return (organisation)
end

_FlashClient_Staff.getPermissionList = function()
    return (permission)
end

_FlashClient_Staff.getRankList = function()
    return (rank)
end

_FlashLand.onReceive("staff:cbPlayerList", function(lightPlayers)
    for k, lightPlayer in pairs(lightPlayers) do
        lightPlayer.rank = _Rank(lightPlayer.rank.id, lightPlayer.rank.label, lightPlayer.rank.weight, lightPlayer.rank.permissions, lightPlayer.rank.baseColor)
        lightPlayer.inventory = _LightInventory(lightPlayer.inventory.id, lightPlayer.inventory.type, lightPlayer.inventory.label, lightPlayer.inventory.capacity, lightPlayer.inventory.content)
    end
    playerList = lightPlayers
end)

_FlashLand.onReceive("staff:cbReportList", function(reports)
    reportList = reports
end)

_FlashLand.onReceive("staff:cbBanList", function(bans)
    banList = bans
end)

_FlashLand.onReceive("staff:cbOrganisationList", function(orgas)
    organisation = orgas
end)

_FlashLand.onReceive("staff:cbPermissionList", function(perms, ranks)
    permission = perms
    rank = ranks
end)

_FlashLand.onReceive("staff:cbRankList", function(ranks)
    rank = ranks
end)