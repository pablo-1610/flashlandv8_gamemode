--[[
  This file is part of FlashLand.
  Created at 09/11/2021 22:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightPlayer
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
---@field public inventory _LightInventory
---@field public loadout _LightLoadout
---@field public name string
---@field public job table
_LightPlayer = {}
_LightPlayer.__index = _LightPlayer

setmetatable(_LightPlayer, {
    __call = function(_, sId, flashId, identifier, rank, identity, cash, skin, outfits, selectedOutfit, accessories, inventory, loadout, name, rpName, job)
        local self = setmetatable({}, _LightPlayer)
        self.flashId = flashId
        self.identifier = identifier
        self.rank = rank
        self.identity = identity
        self.cash = cash
        self.skin = skin
        self.outfits = outfits
        self.selectedOutfit = selectedOutfit
        self.accessories = accessories
        self.sId = sId
        self.inventory = inventory
        self.loadout = loadout
        self.name = name
        self.rpName = rpName
        self.job = job
        return self
    end
})