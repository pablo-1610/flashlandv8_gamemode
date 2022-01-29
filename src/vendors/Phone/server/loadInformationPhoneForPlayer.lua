-- A faire le "Adverts"

_FlashLand.onReceiveWithoutNet("phone:loadInformationPhoneForPlayer", function(source)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    local playerDataPhone = {
        contacts = {},
        informations = {},
        allTweets = {},
        tweets = {},
        mails = {},
        messages = {},
    }
    _FlashServer_Database.query("SELECT * FROM flash_phone_contacts WHERE flashId = @flashId", {
        ["flashId"] = player.flashId
    }, function(result)
        if (result ~= nil) then
            for k, data in pairs(result) do
                data.status = _FlashServer_Phone.getContactIsOnline(data.number)
            end

            playerDataPhone.contacts = result
        end
    end)
    _FlashServer_Database.query("SELECT * FROM flash_players_phone WHERE flashId = @flashId", {
        ["flashId"] = player.flashId
    }, function(result)
        playerDataPhone.informations = result[1]
    end)
    _FlashServer_Database.query("SELECT * FROM flash_phone_tweets", {}, function(result)
        playerDataPhone.allTweets = result[1]
    end)
    _FlashServer_Database.query("SELECT * FROM flash_phone_tweets WHERE flashId = @flashId", {
        ["flashId"] = player.flashId
    }, function(result)
        if (result[1] ~= nil) then
            playerDataPhone.tweets = result[1]
        end
    end)
    _FlashServer_Database.query("SELECT * FROM flash_phone_mails WHERE flashId = @flashId", {
        ["flashId"] = player.flashId
    }, function(result)
        if (result[1] ~= nil) then
            for k, v in pairs(result) do
                if result[k].button ~= nil then
                    result[k].button = json.decode(result[k].button)
                end
            end
            playerDataPhone.mails = result
        end
    end)
    _FlashServer_Database.query("SELECT * FROM flash_phone_messages WHERE flashId = @flashId", {
        ["flashId"] = player.flashId
    }, function(result)
        if (result[1] ~= nil) then
            playerDataPhone.messages = result
        end
    end)
    Wait(1500)
    _FlashLand.toClient("phone:setAllInformationsPhone", _src, playerDataPhone)
end)