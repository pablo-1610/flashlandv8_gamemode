--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Utils.menu_label_change = function()
    return ("~b~Définir ~s~→")
end

_FlashClient_Utils.menu_label_valueOrVoid = function(value)
    return (value == nil and "~r~Vide" or ("~g~%s"):format(value))
end