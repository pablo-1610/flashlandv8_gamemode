--[[
  This file is part of FlashLand.
  Created at 20/11/2021 13:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local speed = 1.0

_FlashLand.onReceiveWithoutNet("admin:toggleNoClip", function(newState)
    if (newState) then
        SetEntityInvincible(PlayerPedId(), true)
        CreateThread(function()
            while (_FlashClient_Staff.getNoClipState()) do
                Wait(1)
                local pCoords = GetEntityCoords(PlayerPedId(), false)
                local camCoords = _FlashClient_Utils.controls_getCamDirection()
                SetEntityVelocity(PlayerPedId(), 0.01, 0.01, 0.01)
                SetEntityCollision(PlayerPedId(), 0, 1)
                FreezeEntityPosition(PlayerPedId(), true)

                if IsControlPressed(0, 32) then
                    pCoords = pCoords + (speed * camCoords)
                end

                if IsControlPressed(0, 269) then
                    pCoords = pCoords - (speed * camCoords)
                end

                if IsDisabledControlJustPressed(1, 15) then
                    speed = speed + 0.3
                end
                if IsDisabledControlJustPressed(1, 14) then
                    speed = speed - 0.3
                    if speed < 0 then
                        speed = 0
                    end
                end
                SetEntityCoordsNoOffset(PlayerPedId(), pCoords, true, true, true)
                SetEntityVisible(PlayerPedId(), 0, 0)
            end
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), 1, 0)
            SetEntityCollision(PlayerPedId(), 1, 1)
        end)
    else
        SetEntityInvincible(PlayerPedId(), false)
    end
end)