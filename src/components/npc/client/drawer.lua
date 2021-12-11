--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:49
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local drawerRunning = false

local gamerTags = {}

local function npcHasGamerTag(lightNpcId)
    return gamerTags[lightNpcId] ~= nil
end

_FlashClient_Npc.tryInvokeDrawer = function()
    if (drawerRunning) then
        return
    end
    drawerRunning = true
    _FlashScheduler.scheduleRepeatingConditionalTask(function()
        local playerPosition = GetEntityCoords(PlayerPedId())
        ---@param lightNpc _LightNpc
        for _, lightNpc in pairs(_FlashClient_Npc.getAll()) do
            if (not (lightNpc.handler)) then
                goto continue
            end
            if (not (lightNpc.visualData.name)) then
                goto continue
            end
            if (#(playerPosition - lightNpc.position) < lightNpc.visualData.name.drawDist) then
                --[[ → Prevent ESC and gamerTag disappearing (could probably cause performance issues)
                if (npcHasGamerTag(lightNpc.id)) then
                    goto continue
                end
                --]]
                gamerTags[lightNpc.id] = CreateFakeMpGamerTag(lightNpc.handler, lightNpc.visualData.name.label, true, false, 'NPC', 1)
                SetMpGamerTagColour(gamerTags[lightNpc.id], 0, lightNpc.visualData.name.color)
                if (_ConfigClient.Npc.showHealth) then
                    SetMpGamerTagVisibility(gamerTags[lightNpc.id], 2, true)
                end
                SetMpGamerTagVisibility(gamerTags[lightNpc.id], 14, true)
                SetMpGamerTagColour(gamerTags[lightNpc.id], 2, lightNpc.visualData.name.color)
                SetMpGamerTagColour(gamerTags[lightNpc.id], 14, lightNpc.visualData.name.color)
                SetMpGamerTagAlpha(gamerTags[lightNpc.id], 2, 255)
                SetMpGamerTagAlpha(gamerTags[lightNpc.id], 14, 255)
                SetMpGamerTagHealthBarColor(gamerTags[lightNpc.id], lightNpc.visualData.name.color)
            else
                if (npcHasGamerTag(lightNpc.id)) then
                    RemoveMpGamerTag(gamerTags[lightNpc.id])
                    gamerTags[lightNpc.id] = nil
                end
            end
            :: continue ::
        end
    end, function()
        for lightNpcId, gamerTag in pairs(gamerTags) do
            RemoveMpGamerTag(gamerTag)
            gamerTags[lightNpcId] = nil
        end
        drawerRunning = false
    end, function()
        return (_FlashClient_Npc.isAnyNpcActive())
    end, 0, 0)
end