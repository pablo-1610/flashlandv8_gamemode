--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashClient_Phone
_FlashClient_Phone = {}

allInformationPhone = {
    contacts = {},
    messages = {},
    allTweets = {},
    tweets = {},
    mails = {},
    informations = {},
    suggestedContacts = {},
    call = {},
    recentCall = {}
}

local isOpen = false
local isCall = false

_FlashClient_Phone.phoneIsOpen = function()
    return (isOpen)
end

_FlashClient_Phone.playerIsCall = function()
    return (isCall)
end

_FlashClient_Phone.openPhone = function()
    isOpen = true
end

_FlashClient_Phone.playerStartCall = function()
    isCall = true
end

_FlashClient_Phone.closePhone = function()
    isOpen = false
end

_FlashClient_Phone.playerFinishCall = function()
    isCall = false
end

_FlashClient_Phone.getNumberInContactPhone = function(number, contacts)
    local contactName = number
    for _, data in pairs(contacts) do
        if (contactName == data.number) then
            contactName = data.name
        end
    end
    return (contactName)
end

_FlashClient_KeyBind.addKey("f1", "Téléphone", function()
    if (_FlashClient_Phone.phoneIsOpen()) then
        return
    end
    _FlashLand.toServer("phone:openPhoneCheck")
end)

_FlashLand.loadedComponent("phone")