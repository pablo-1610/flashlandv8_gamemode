---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Los Narcos.
  
  File [PabloUI] created at [22/05/2021 02:30]

  Copyright (c) Los Narcos - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class PabloUI
PabloUI = {}
PabloUI.Panels = {}
PabloUI.CurrentPanel = nil
PabloUI.CurrentCursor = 1

---CreateMenu
---@public
---@return Menu
function PabloUI:CreatePanel(uniqueId, title, desc, color, depend)
    local panel = Panel(uniqueId, title, desc, color, depend)
    PabloUI.Panels[uniqueId] = panel
    return panel
end

---MenuExists
---@public
---@return boolean
function PabloUI:PanelExists(uniqueId)
    return PabloUI.Panels[uniqueId] ~= nil
end

---GetPanel
---@public
---@return Panel
function PabloUI:GetPanel(uniqueId)
    return PabloUI.Panels[uniqueId]
end

---DrawTexts
---@public
---@return void
function PabloUI:DrawTexts(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
end

---DisplayPanel
---@public
---@return void
function PabloUI:DisplayPanel(basePanel)
    PabloUI.CurrentPanel = basePanel
    PabloUI.CurrentCursor = 1
    CreateThread(function()
        while PabloUI.CurrentPanel == basePanel do
            Wait(0)
            PabloUI.Panels[PabloUI.CurrentPanel.uniqueId]:Draw()
        end
    end)
end