--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Player
---@field public flashId number
---@field public identifier string
---@field public identity table
---@field public cash number
---@field public skin table
---@field public outfits table
---@field public selectedOutfit number
---@field public accessories table
---@field public rank _Rank
---@field public sId number
---@field public spawned boolean
---@field public gameType number
---@field public inventory _Inventory
---@field public loadout _Loadout
---@field public rpName string
---@field public name string
_Player = {}
_Player.__index = _Player

setmetatable(_Player, {
    __call = function(_, sId, flashId, identifier, rankId, identity, cash, skin, outfits, selectedOutfit, accessories, number)
        local self = setmetatable({}, _Player)
        self.flashId = flashId
        self.identifier = identifier
        self.rankId = rankId
        self.rank = _FlashServer_Ranks.getOrLowest(self.rankId)
        self.identity = identity
        self.rpName = ("%s %s"):format(self.identity.firstname, self.identity.lastname)
        -- TODO → Fake identity implementation
        self.cash = cash
        self.skin = skin
        self.outfits = outfits
        self.selectedOutfit = selectedOutfit
        self.accessories = accessories
        self.sId = sId
        --
        self.job = {}
        self.organisation = {}
        self.spawned = false
        self.gameType = _FlashEnum_GAMETYPE.RP
        self.name = GetPlayerName(self.sId)
        self.number = number
        return self
    end
})

function _Player:getPlayerCash()
    return (self.cash)
end

function _Player:loadInventory(cb)
    _FlashServer_Inventory.playerGetOrCreate(self.sId, function(inv)
        self.inventory = inv
        if (cb ~= nil) then
            cb()
        end
    end)
end

function _Player:loadLoadout(cb)
    _FlashServer_Loadout.playerGetOrCreate(self.sId, function(ld)
        self.loadout = ld
        if (cb ~= nil) then
            cb()
        end
    end)
end

function _Player:loadJob(cb)
    _FlashServer_Job:retrievePlayerJob(self.flashId, function(job, job_grade)
        if (not (_FlashServer_Job:exists(job)) or job == nil) then
            ---@type _Job
            local _job = _FlashServer_Job:get(_ConfigServer.Start.job)
            ---@type _JobGrade
            local _grade = _job:getLastGrade()
            self.job = { job = _job.id, grade = _grade.id, _job = _job, _grade = _grade }
        else
            ---@type _Job
            local _job = _FlashServer_Job:get(job)
            local _grade = nil
            if (not (_job:gradeExists(job_grade)) or job_grade == nil) then
                _grade = _job:getLastGrade()
            else
                _grade = _job:getGrade(job_grade)
            end
            self.job = { job = _job.id, grade = _grade.id, _job = _job, _grade = _grade }
        end
        cb()
    end)
end

function _Player:loadOrganisation(cb)
    _FlashServer_Organisation.retrievePlayerOrganisation(self.flashId, function(job, job_grade)
        if (job == _ConfigServer.Start.organisation) then
            self.organisation = { orga = _ConfigServer.Start.organisation, grade = { name = "citoyen", label = "Citoyen", gradeId = 0 } }
        else
            if (not (_FlashServer_Organisation.exist(job)) or job == nil) then
                self.organisation = { orga = _ConfigServer.Start.organisation, grade = { name = "citoyen", label = "Citoyen", gradeId = 0 } }
            else
                if (not (_FlashServer_Organisation.gradeExist(job, tonumber(job_grade))) or job_grade == nil) then
                    self.organisation = { orga = _ConfigServer.Start.organisation, grade = { name = "citoyen", label = "Citoyen", gradeId = 0 } }
                else
                    ---@type _OrgaGrade
                    local grade = _FlashServer_Organisation.getGrade(job, job_grade)
                    self.organisation = { orga = job, grade = grade }
                end
            end
        end
        cb()
    end)
end

function _Player:getDbPosition(consumer)
    _FlashServer_Database.query("SELECT position FROM flash_players_positions WHERE flashId = @flashId", {
        ["flashId"] = self.flashId
    }, function(result)
        consumer(json.decode(result[1].position))
    end)
end

function _Player:savePosition()
    --_FlashLand.log(("Tentative de sauvegarde position du sID ^3%s^7..."):format(self.sId))
    if (self.gameType == _FlashEnum_GAMETYPE.RP and self.spawned) then
        local ped = GetPlayerPed(self.sId)
        local position = GetEntityCoords(ped)
        position = { coords = { x = position.x, y = position.y, z = position.z }, heading = GetEntityHeading(ped) }
        _FlashServer_Database.execute("UPDATE flash_players_positions SET position = @position WHERE flashId = @flashId", {
            ["position"] = json.encode(position),
            ["flashId"] = self.flashId
        })
        --_FlashLand.log(("Sauvegarde la position du sID ^3%s"):format(self.sId))
    end
end

function _Player:saveData()
    _FlashServer_Database.execute("UPDATE flash_players SET rankId = @rankId, cash = @cash WHERE flashId = @flashId", {
        ["rankId"] = self.rank.id,
        ["cash"] = self.cash,
        ["flashId"] = self.flashId
    })
end

function _Player:saveOrganisationGrade()
    _FlashServer_Database.execute("UPDATE flash_players_organisation SET orga = @orga, orga_grade = @orga_grade WHERE flashId = @flashId", {
        ["orga"] = self.organisation.orga,
        ["orga_grade"] = self.organisation.grade.name,
        ["flashId"] = self.flashId
    })
end

function _Player:setSpawned()
    self.spawned = true
end

function _Player:getPlayerPos()
    return (GetEntityCoords(GetPlayerPed(self.sId)))
end

function _Player:setTeleportPlayer(position)
    SetEntityCoords(GetPlayerPed(self.sId), position.x, position.y, position.z)
end

function _Player:sendData()
    local lightPlayer = _FlashServer_Players.getLightPlayer(self.sId)
    _FlashLand.toClient("cache:setCache", self.sId, "playerData", lightPlayer)
end

function _Player:serverResponded()
    _FlashLand.toClient("serverReturnedCb", self.sId)
end

-- TODO → Send a simple notification, not an advanced one
function _Player:sendSystemMessage(type, message)
    _FlashLand.toClient(("utils:messenger_system_%s"):format(type:lower()), self.sId, message)
end

function _Player:sendAdvancedNotificationMugShot(mugShotPed, sender, subject, content, iconType)
    _FlashLand.toClient("utils:messenger_playerPed", self.sId, mugShotPed, sender, subject, content, iconType)
end

function _Player:getPed()
    return (GetPlayerPed(self.sId))
end

function _Player:getName()
    return (self.name)
end

function _Player:getServerId()
    return (self.sId)
end

function _Player:getRpIdentity()
    return (("%s %s"):format(self.identity.firstname, self.identity.lastname))
end

---@param newRank _Rank
function _Player:setGroup(newRank, notify)
    self.rank = newRank
    self.rankId = self.rank.id
    self:saveData()
    self:sendData()
    if (notify) then
        _FlashServer_Players.messenger_system_info(self.sId, ("Grade changé: ~y~%s"):format(self.rank.label))
    end
end

function _Player:setGroupId(newRankId, notify)
    if (not (_FlashServer_Ranks.exists(newRankId))) then
        _FlashLand.err(("Tentative de changement de group id inexistant (^3%s^7|^3%s^7)"):format(self.flashId, newRankId))
        return
    end
    ---@type _Rank
    local rank = _FlashServer_Ranks.get(newRankId)
    self:setGroup(rank, notify)
end

function _Player:kickPlayer(reason)
    DropPlayer(self.source, "test")
end