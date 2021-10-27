--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:21
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local builder = {
    identity = {
        firstname = nil,
        lastname = nil,
        age = nil
    },

    skin = {

    }
}

local function validateInfos()
    return (true)
end

local function createMenus()
    local title, desc = "CUSTOMISATION", "Créez votre personnage"
    local main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
    local identity = RageUI.CreateSubMenu(main, title, desc, nil, nil, "root_cause", "black_red")
    return ({ main, identity })
end

_FlashLand.onReceive("creator:initMenu", function()
    local menus = createMenus()
    RageUI.Visible(menus[1], true)
    CreateThread(function()
        while (true) do
            Wait(0)
            RageUI.IsVisible(menus[1], function()
                RageUI.Button("Customisation de l'identité", "Vos informations personnelles", { RightLabel = "→→" }, true, {}, menus[2])
                RageUI.Button("Customisation du personnage", "Vos informations personnelles", { RightLabel = "→→" }, true, {})
                RageUI.Button("Valider et commencer", "Confirmez vos informations et commencez l'aventure ~r~FlashLand", { Color = { BackgroundColor = { 0, 255, 0, 25 } } }, validateInfos(), {})
            end)

            RageUI.IsVisible(menus[2], function()
                RageUI.Button(("Prénom: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.firstname)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
                    onSelected = function()
                        local input = _FlashClient_Utils.input_showBox("Prénom:", "", 30, false)
                    end
                })
                RageUI.Button(("Nom: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.firstname)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {

                })
                RageUI.Button(("Âge: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.firstname)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {

                })
            end)
        end
    end)
end)