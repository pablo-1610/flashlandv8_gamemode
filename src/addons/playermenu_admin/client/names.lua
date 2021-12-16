--[[
  This file is part of FlashLand.
  Created at 20/11/2021 16:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local playerTags = {}

_FlashLand.onReceiveWithoutNet("admin:toggleNames", function(newState)
    if (newState) then
        CreateThread(function()
            while (_FlashClient_Staff.getNamesState()) do
                Wait(0)
                local playerPed = PlayerPedId()
                for _, player in pairs(GetActivePlayers()) do
                    local othersPed = GetPlayerPed(player)
                    if playerPed ~= othersPed then
                        local distanceStaffToOtherPlayer = #(GetEntityCoords(playerPed) - GetEntityCoords(player))
                        if distanceStaffToOtherPlayer <= 7000.0 then
                            playerTags[player] = CreateFakeMpGamerTag(othersPed, ("[%s] %s"):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, "", 0)
                            SetMpGamerTagAlpha(playerTags[player], 0, 255)
                            SetMpGamerTagAlpha(playerTags[player], 2, 255)
                            SetMpGamerTagAlpha(playerTags[player], 4, 255)
                            SetMpGamerTagAlpha(playerTags[player], 7, 255)
                            SetMpGamerTagVisibility(playerTags[player], 0, true)
                            SetMpGamerTagVisibility(playerTags[player], 2, true)
                            SetMpGamerTagVisibility(playerTags[player], 4, NetworkIsPlayerTalking(player))
                            SetMpGamerTagColour(playerTags[player], 7, 55)
                            if NetworkIsPlayerTalking(player) then
                                SetMpGamerTagHealthBarColour(playerTags[player], 211)
                                SetMpGamerTagColour(playerTags[player], 4, 211)
                                SetMpGamerTagColour(playerTags[player], 0, 211)
                            else
                                SetMpGamerTagHealthBarColour(playerTags[player], 0)
                                SetMpGamerTagColour(playerTags[player], 4, 0)
                                SetMpGamerTagColour(playerTags[player], 0, 0)
                            end
                        else
                            RemoveMpGamerTag(playerTags[player])
                            playerTags[player] = nil
                        end
                    end
                end
            end
            for _, player in pairs(playerTags) do
                RemoveMpGamerTag(player)
            end
            playerTags = {}
        end)
    end
end)