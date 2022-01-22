--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:21
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("phone:setAllInformationsPhone", function(information)
    local phoneData = {}
    phoneData.MetaData = {}

    if (information.informations.profilepicture ~= nil) then
        phoneData.MetaData.profilepicture = information.informations.profilepicture
        allInformationPhone.informations.profilepicture = information.informations.profilepicture
    end
    if (information.informations.background ~= nil) then
        phoneData.MetaData.background = information.informations.background
        allInformationPhone.informations.background = information.informations.background
    else
        phoneData.MetaData.background = _ConfigPhone.defaultBackground
        allInformationPhone.informations.background = _ConfigPhone.defaultBackground
    end
    if (information.contacts ~= nil) then
        phoneData.MetaData.Contacts = information.contacts
        allInformationPhone.contacts = information.contacts
    end
    if (information.messages ~= nil) then
        local messages = {}
        for _, data in pairs(information.messages) do
            messages[data.number] = {
                name = _FlashServer_Phone.getNumberInContactPhone(data.number, phoneData.MetaData.Contacts),
                number = data.number,
                messages = json.decode(data.messages)
            }
        end
        phoneData.MetaData.Chats = messages
        allInformationPhone.messages = messages
    end
    if (information.allTweets ~= nil) then
        phoneData.MetaData.Tweets = information.allTweets
        --phoneData.MetaData.id = (information.allTweets[#information.allTweets].id + 1)
        allInformationPhone.allTweets = information.allTweets
    end
    if (information.tweets ~= nil) then
        phoneData.MetaData.SelfTweets = information.tweets
        allInformationPhone.tweets = information.tweets
    end
    if (information.mails ~= nil) then
        phoneData.MetaData.Mails = information.mails
        allInformationPhone.mails = information.mails
    end

    local playerJob = "Police"

    SendNUIMessage({
        action = "LoadPhoneData",
        PhoneData = phoneData,
        PlayerData = _FlashClient_Cache.getPlayer(),
        PlayerJob = playerJob,
        applications = _ConfigPhone.applications
    })
end)