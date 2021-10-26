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
---@field public sId
_Player = {}
_Player.__index = _Player

setmetatable(_Player, {
    __call = function(_, sId, flashId, identifier, rankId, identity, cash, skin, outfits, selectedOutfit, accessories)
        local self = setmetatable({}, _Player)
        self.flashId = flashId
        self.identifier = identifier
        self.rankId = rankId
        self.rank = _FlashServer_Ranks.getOrLowest(rankId)
        self.identity = identity
        self.cash = cash
        self.skin = skin
        self.outfits = outfits
        self.selectedOutfit = selectedOutfit
        self.accessories = accessories
        self.sId = sId
    end
})