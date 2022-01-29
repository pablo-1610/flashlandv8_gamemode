--[[
  This file is part of FlashLand.
  Created at 28/01/2022 13:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("phone:playerStartCall", function(number)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
            return
        end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        player:serverResponded()
        return
    end
    local target = _FlashServer_Phone.getContactIsOnline(number)
    if (target ~= nil) then
        if (_FlashServer_Phone.playerCall(target.identifier)) then
            _FlashLand.toClient("phone:playerIsCallInformation", _src, true, true)
        else
            _FlashLand.toClient("phone:playerIsCallInformation", _src, true, false)
        end
    else
        _FlashLand.toClient("phone:playerIsCallInformation", _src, false, false)
    end
    player:serverResponded()
end)

_FlashLand.onReceive("phone:playerStartCallToOtherPlayer", function(callData, anonymousCall)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
            return
        end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        player:serverResponded()
        return
    end
    local target = _FlashServer_Phone.getContactIsOnline(callData.TargetData)
    if (target ~= nil) then
        _FlashLand.toClient("phone:targetGetCall", target.sId, player.number, callData.CallId, anonymousCall)
    end
end)

_FlashLand.onReceive("phone:TargetStartCall", function(status)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
            return
        end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        player:serverResponded()
        return
    end
    if (_FlashServer_Phone.playerCall(player.identifier)) then
        _FlashServer_Phone.startPlayerCall(player.identifier)
    else
        _FlashServer_Phone.finishPlayerCall(player.identifier)
    end
end)

_FlashLand.onReceive("phone:targetMissingCall", function(callType, callData)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
            return
        end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.inventory:hasItem(_ConfigPhone.phoneItemName:lower()))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_NOT_PHONE_ITEM)
        player:serverResponded()
        return
    end
    local hour = os.date("%H")
    local minute = os.date("%M")
    local date = ("%s:%s"):format(hour, minute)
    _FlashLand.toClient("phone:addRecentCall", _src, callData, date, callType)
    local target = _FlashServer_Phone.getContactIsOnline(data.number)
    if (target ~= nil) then
        local targetInformation = {name = target.rpName, number = target.number, anonymousCall = anonymousCall}
        _FlashLand.toClient("phone:addRecentCall", _src, targetInformation, date, "outgoing")
    end
end)