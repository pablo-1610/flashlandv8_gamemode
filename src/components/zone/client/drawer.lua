--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:49
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local drawerRunning = false
local isOnCoolDown = false

local function doCoolDown()
    _FlashScheduler.scheduleDelayedTask(function()
        isOnCoolDown = false
    end, 200)
end

_FlashClient_Zone.tryInvokeDrawer = function()
    if (drawerRunning) then
        return
    end
    drawerRunning = true
    _FlashScheduler.scheduleRepeatingConditionalTask(function()
        local playerPosition = GetEntityCoords(PlayerPedId())
        ---@param lightZone _LightZone
        for _, lightZone in pairs(_FlashClient_Zone.getAll()) do
            if (lightZone.hideIfAMenuIsOpen and _FlashClient_Menu.isMenuOpen()) then
                goto continue
            end
            lightZone:draw()
            if (lightZone:canInteract(playerPosition)) then
                lightZone:sendHelpMessage()
                if (IsControlJustPressed(0, 51) and not (isOnCoolDown) and not (isWaitingForServer)) then
                    lightZone:interact()
                    isOnCoolDown = true
                    doCoolDown()
                end
            end
            :: continue ::
        end
    end, function()
        drawerRunning = false
    end, function()
        return (_FlashClient_Zone.isAnyZoneActive())
    end, 0, 0)
end