--[[
  This file is part of FlashLand.
  Created at 26/02/2022 15:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class Property
---@field public id number
---@field public name string
---@field public interiorId string
---@field public enterPos _Zone
---@field public exitPos _Zone
---@field public safePos _Zone
---@field public clothePos _Zone
---@field public managePos _Zone
---@field public blipPos _Blip
---@field public securityLevel number
---@field public owner table
---@field public peopleInAppart table
---@field public instanceId number
---@field public notification table
_Property = {}
_Property.__index = _Property

setmetatable(_Property, {
    __call = function(_, id, name, interiorId, enterPos, exitPos, safePos, clothePos, managePos, blipPos, securityLevel)
        local self = setmetatable({}, _Property)
        self.id = id
        self.name = name
        self.interiorId = interiorId
        self.enterPos = _FlashServer_Zones.createRestricted(vector3(enterPos.x, enterPos.y, enterPos.z), { 245, 0, 0, 245 }, function(_src, player)

        end, "Appuyez sur ~INPUT_CONTEXT~ pour entrer dans l'appartement !", 20.0, 2.35, true)
        self.exitPos = _FlashServer_Zones.createRestricted(vector3(exitPos.x, exitPos.y, exitPos.z), { 245, 0, 0, 245 }, function(_src, player)

        end, "Appuyez sur ~INPUT_CONTEXT~ pour sortir de l'appartement !", 20.0, 2.35, true)
        self.safePos = _FlashServer_Zones.createRestricted(vector3(safePos.x, safePos.y, safePos.z), { 245, 0, 0, 245 }, function(_src, player)

        end, "Appuyez sur ~INPUT_CONTEXT~ pour sortir de l'appartement !", 20.0, 2.35, true)
        self.clothePos = _FlashServer_Zones.createRestricted(vector3(clothePos.x, clothePos.y, clothePos.z), { 245, 0, 0, 245 }, function(_src, player)

        end, "Appuyez sur ~INPUT_CONTEXT~ pour sortir de l'appartement !", 20.0, 2.35, true)
        self.managePos = _FlashServer_Zones.createRestricted(vector3(managePos.x, managePos.y, managePos.z), { 245, 0, 0, 245 }, function(_src, player)

        end, "Appuyez sur ~INPUT_CONTEXT~ pour sortir de l'appartement !", 20.0, 2.35, true)
        self.blip = _FlashServer_Blips.createPublic(vector3(blipPos.x, blipPos.y, blipPos.z), 40, 37, _Config.genericBlipSize, self.name)
        self.securityLevel = securityLevel
        self.owner = {}
        self.peopleInAppart = {}
        self.instanceId = math.random(50000, 99999)
        self.notification = {}
        return (self)
    end
})

function _Property:loadOwnerProperty()
    _FlashServer_Database.query("SELECT * FROM flash_property_owner WHERE property_id = @property_id", {
        ["property_id"] = self.id
    }, function(owners)
        if (owners[1]) then
            local playerData = {}
            for _, data in pairs(owners) do
                _FlashServer_Database.query("SELECT * FROM flash_players WHERE flashId = @flashId", {
                    ["flashId"] = data.flashId
                }, function(players)
                    if (players[1]) then
                        for _, player in pairs(players) do
                            playerData[player.flashId] = { identifier = player.identifier, name = ("%s %s"):format(player.identity.firstname, player.identity.lastname), level = data.owner_level }
                            table.insert(self.owner, playerData[player.flashId])
                        end
                    end
                end)
            end
        end
    end)
end

function _Property:getPlayerExist(flashId)
    for _, owner in pairs(self.owner) do
        if (owner[flashId]) then
            return (true)
        end
    end
    return (false)
end

function _Property:getAllOwner()
    return (self.owner)
end

function _Property:getPlayerOwner(flashId)
    if (not (self:getPlayerExist(flashId))) then
        return (nil)
    end
    for _, owner in pairs(self.owner) do
        if (owner[flashId]) then
            return (owner)
        end
    end
    return (nil)
end

---@param player _Player
function _Property:addOwner(player, level)
    if (self:getPlayerExist(player.flashId)) then
        return
    end
    local playerData = {}
    playerData[player.flashId] = { identifier = player.identifier, name = player.rpName, level = level }
    table.insert(self.owner, playerData[player.flashId])
end

function _Property:removeOwner(flashId)
    if (self:getPlayerExist(flashId)) then
        for index, owner in pairs(self.owner) do
            if (owner[flashId]) then
                table.remove(self.owner, index)
            end
        end
    end
end

function _Property:updatePropertyOwner()
    for _, player in pairs(self.peopleInAppart) do
        _FlashLand.toClient("updatePropertyOwner", player.source, self.owner)
    end
end

function _Property:getAllPlayersInAppart()
    return (self.peopleInAppart)
end

function _Property:getPlayerInAppartExist(_src)
    for _, player in pairs(self.peopleInAppart) do
        if (player.source == _src) then
            return (true)
        end
    end
    return (false)
end

function _Property:playerJoinProperty(_src)
    if (self:getPlayerInAppartExist(_src)) then
        return
    end
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    local playerData = { source = player.sId, name = player.rpName }
    table.insert(self.peopleInAppart, playerData)
    if (not (_FlashServer_Instances.getPlayerInstance(player.sId) == self.instanceId)) then
        _FlashServer_Instances.setOnInstance(player.sId, self.instanceId)
    end
    player:setTeleportPlayer(self.exitPos.location)
    self:sendMessageForPlayerInAppart((_FlashEnum_PropertyMessage.PLAYER_ENTER_PROPERTY):format(player.rpName))
    self:updatePeopleInProperty()
end

function _Property:playerLeftProperty(_src)
    if (not (self:getPlayerInAppartExist(_src))) then
        return
    end
    if (not (_FlashServer_Players.exists(_src))) then
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashServer_Instances.setOnPublicInstance(player.sId)
    player:setTeleportPlayer(self.enterPos.location)
    for index, playerInAppartData in pairs(self.peopleInAppart) do
        if (playerInAppartData.source == player.sId) then
            table.remove(self.peopleInAppart, index)
        end
    end
    self:sendMessageForPlayerInAppart((_FlashEnum_PropertyMessage.PLAYER_LEFT_PROPERTY):format(player.rpName))
    self:updatePeopleInProperty()
end

function _Property:updatePeopleInProperty()
    for _, player in pairs(self.peopleInAppart) do
        _FlashLand.toClient("updatePropertyPeople", player.source, self.peopleInAppart)
    end
end

function _Property:sendMessageForPlayerInAppart(message)
    for _, player in pairs(self.peopleInAppart) do
        _FlashLand.toClient("utils:messenger_playerPed", player.source, player.source, _Static_GenericMessages.INTERACTION, message, "")
    end
end