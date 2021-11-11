--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local isMenuOpen = false

_FlashClient_Menu = {}

_FlashClient_Menu.isMenuOpen = function()
    return (isMenuOpen)
end

_FlashClient_Menu.tryOpenMenu = function(cb)
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    cb()
end

_FlashClient_Menu.menuClosed = function()
    isMenuOpen = false
end

_FlashLand.loadedComponent("menu")