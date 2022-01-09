---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Los Narcos.
  
  File [Menu] created at [22/05/2021 03:05]

  Copyright (c) Los Narcos - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local baseX,baseY,baseWidth,baseHeight = 0.1,0.1,0.15,0.06

local controls = {
    down = {
        { 0, 173 },
        { 1, 173 },
        { 2, 173 },
        { 0, 242 },
        { 1, 242 },
        { 2, 242 },
    },

    up = {
        { 0, 172 },
        { 1, 172 },
        { 2, 172 },
        { 0, 241 },
        { 1, 241 },
        { 2, 241 },
    },

    select = {
        { 0, 201 },
        { 1, 201 },
        { 2, 201 },
    },

    back = {
        { 0, 177 },
        { 1, 177 },
        { 2, 177 },
        { 0, 199 },
        { 1, 199 },
        { 2, 199 },
    }
}

---@class Panel
---@field title string
---@field desc string
---@field theme table {r,b,g}
---@field uniqueId string
---@field elements table
---@field closable boolean
---@field depend string

-- Private
---@field close boolean
Panel = {}
Panel.__index = Panel

setmetatable(Panel, {
    __call = function(_, uniqueId, title, desc, theme, depend)
        local self = setmetatable({}, Panel);
        self.title = title
        self.desc = desc
        self.theme = theme
        self.uniqueId = uniqueId
        self.close = false
        self.closable = true
        self.elements = {}
        if PabloUI:PanelExists(depend) then
            self.depend = depend
        end
        return self;
    end
})

---Close
---@public
---@return void
function Panel:Close()
    self.close = true
end

---SetClosable
---@public
---@return void
function Panel:SetClosable(boolean)
    self.closable = boolean
end

---AddButton
---@public
---@return void
function Panel.CreateButton(title, rightlabel, active, selected, tomenu)
    return {
        type = 1,
        title = title,
        rightlabel = rightlabel or "",
        active = active or function()  end,
        selected = selected or function()  end,
        tomenu = tomenu
    }
end

---AddCheckBox
---@public
---@return void
function Panel.CreateCheckBox(title, active, onStateChange, currentState)
    return {
        type = 2,
        title = title,
        active = active or function()  end,
        onStateChange = onStateChange or function()  end,
        currentState = currentState or false
    }
end

---SetElement
---@public
---@retrun void
function Panel:SetElement(elementId, element)
    if elementId > (#self.elements+1) then
        return
    end
    self.elements[elementId] = element
end

---SetDepend
---@public
---@return void
function Panel:SetDepend(panel)
    self.depend = panel
end

---Draw
---@public
---@return void
function Panel:Draw()
    if self.close then
        PabloUI.CurrentPanel = nil
        return
    end

    DrawRect(baseX, baseY, baseWidth+0.01, baseHeight+0.01, self.theme[1], self.theme[2], self.theme[3], 155)
    DrawRect(baseX, baseY, baseWidth, baseHeight, 0, 0, 0, 155)

    PabloUI:DrawTexts(baseX, baseY - 0.0275, self.title, true, 0.85, {255, 255, 255, 255}, 6, 0)

    local starting = baseY
    if self.desc ~= nil then
        DrawRect(baseX, baseY + 0.05, baseWidth+0.01, baseHeight-0.030, self.theme[1], self.theme[2], self.theme[3], 155)
        PabloUI:DrawTexts(baseX, baseY + 0.03450, self.desc, true, 0.40, {255, 255, 255, 255}, 6, 0)
        starting = (baseY + 0.0275)
    end

    if #self.elements > 0 and PabloUI.CurrentCursor > #self.elements then
        PabloUI.CurrentCursor = 1
    elseif PabloUI.CurrentCursor < 1 then
        PabloUI.CurrentCursor = #self.elements
    end

    for k,v in pairs(self.elements) do
        if PabloUI.CurrentCursor == k then
            DrawRect(baseX-0.078, starting+0.052+((k-1)*0.030), 0.0045, baseHeight-0.030, 255, 255, 255, 255)
        else
            DrawRect(baseX-0.078, starting+0.052+((k-1)*0.030), 0.0045, baseHeight-0.030, self.theme[1], self.theme[2], self.theme[3], 155)
        end
        if v.type == 1 then
            DrawRect(baseX, starting+0.052+((k-1)*0.030), baseWidth+0.01, baseHeight-0.030, 0, 0, 0, 155)
            PabloUI:DrawTexts(baseX - 0.073, starting+0.0379+((k-1)*0.030), v.title, false, 0.40, {255, 255, 255, 255}, 6, 0)
            if v.rightlabel ~= nil then
                PabloUI:DrawTexts(baseX + 0.065, starting+0.0379+((k-1)*0.030), v.rightlabel, false, 0.40, {255, 255, 255, 255}, 6, 0)
            end
        elseif v.type == 2 then
            DrawRect(baseX, starting+0.052+((k-1)*0.030), baseWidth+0.01, baseHeight-0.030, 0, 0, 0, 155)
            PabloUI:DrawTexts(baseX - 0.073, starting+0.0379+((k-1)*0.030), v.title, false, 0.40, {255, 255, 255, 255}, 6, 0)
            if v.currentState then
                DrawRect(baseX + 0.06985, starting+0.052+((k-1)*0.030), 0.010, 0.015, 0, 255, 0, 255)
            else
                DrawRect(baseX + 0.06985, starting+0.052+((k-1)*0.030), 0.010, 0.015, 255, 0, 0, 255)
            end
        end
    end

    local skip = false

    for k,v in pairs(controls.back) do
        if IsControlJustPressed(v[1], v[2]) and not skip then
            skip = true
            if self.depend ~= nil then
                PabloUI.CurrentPanel = PabloUI.Panels[self.depend]
                PabloUI:DisplayPanel(PabloUI.Panels[self.depend])
                PlaySoundFrontend(-1, "BACK", "HUD_FREEMODE_SOUNDSET", true)
            else
                if self.closable then
                    PlaySoundFrontend(-1, "BACK", "HUD_FREEMODE_SOUNDSET", true)
                    PabloUI.CurrentPanel = nil
                else
                    PlaySoundFrontend(-1, "CANCEL", "HUD_FREEMODE_SOUNDSET", true)
                end
            end
        end
    end

    for k,v in pairs(controls.down) do
        if IsControlJustPressed(v[1], v[2]) and not skip then
            skip = true
            PabloUI.CurrentCursor = PabloUI.CurrentCursor + 1
            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET", true)
        end
    end

    for k,v in pairs(controls.up) do
        if IsControlJustPressed(v[1], v[2]) and not skip then
            skip = true
            PabloUI.CurrentCursor = PabloUI.CurrentCursor - 1
            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET", true)
        end
    end

    for k,v in pairs(controls.select) do
        if IsControlJustPressed(v[1], v[2]) and not skip then
            skip = true
            local element = self.elements[PabloUI.CurrentCursor]
            if element.type == 1 then
                PlaySoundFrontend(-1, "SELECT", "HUD_FREEMODE_SOUNDSET", true)
                element.selected()
                if element.tomenu ~= nil then
                    PabloUI.CurrentPanel = PabloUI.Panels[element.tomenu]
                    PabloUI:DisplayPanel(PabloUI.Panels[element.tomenu])
                end
            elseif element.type == 2 then
                PlaySoundFrontend(-1, "SELECT", "HUD_FREEMODE_SOUNDSET", true)
                element.currentState = not element.currentState
                element.onStateChange(element.currentState)
            end
        end
    end
end
