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

_FlashClient_Utils.menu_label_select = function()
    return ("~o~Choisir ~s~→")
end

_FlashClient_Utils.menu_label_valueOrVoid = function(value)
    return (value == nil and "~r~Vide" or ("~g~%s"):format(value))
end

_FlashClient_Utils.menu_display_greenIfTrue = function(value)
    return (value == true and "~g~" or "")
end

_FlashClient_Utils.menu_color_greenIfTrue = function(value)
    return (value == true and { BackgroundColor = { 0, 255, 0, 100 } } or {})
end

_FlashClient_Utils.menu_label_selectOrSelected = function(value)
    return (value and "~g~Sélectionné" or "~o~Sélectionner ~s~→")
end