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
    return (builder.identity.firstname ~= nil and builder.identity.lastname ~= nil and builder.identity.age ~= nil and tonumber(builder.identity.age) ~= nil and builder.identity.age >= 18 and builder.identity.age <= 99)
end

local function createMenus()
    local title, desc = "CUSTOMISATION", "Créez votre personnage"
    local main = RageUI.CreateMenu(title, desc, nil, nil, "root_cause", "black_red")
    main.Closable = false
    local identity = RageUI.CreateSubMenu(main, title, desc, nil, nil, "root_cause", "black_red")
    local character = RageUI.CreateSubMenu(main, title, desc, nil, nil, "root_cause", "black_red")
    return ({ main, identity, character })
end

_FlashLand.onReceive("creator:initMenu", function()
    local menus = createMenus()
    RageUI.Visible(menus[1], true)
    CreateThread(function()
        while (true) do
            Wait(0)
            RageUI.IsVisible(menus[1], function()
                RageUI.Button("Customisation de l'identité", "Vos informations personnelles", { RightLabel = "→→" }, true, {}, menus[2])
                RageUI.Button("Customisation du personnage", "Vos informations personnelles", { RightLabel = "→→" }, true, {}, menus[3])
                RageUI.Button("Valider et commencer", "Confirmez vos informations et commencez l'aventure ~r~FlashLand", { Color = { BackgroundColor = { 0, 255, 0, 25 } } }, validateInfos(), {})
            end)
            RageUI.IsVisible(menus[2], function()
                RageUI.Button(("Prénom: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.firstname)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
                    onSelected = function()
                        local input = _FlashClient_Utils.input_showBox("Prénom:", "", 30, false)
                        if (input ~= nil) then
                            local match = _FlashClient_Utils.regex_name(input)
                            if (not (match)) then
                                _FlashClient_Utils.notifications_template_error("Ce prénom est incorrect. Assurez vous qu'il commence par une ~y~majuscule~s~.")
                            else
                                builder.identity.firstname = input
                                _FlashClient_Utils.notifications_template_success("Prénom enregistré")
                            end
                        end
                    end
                })
                RageUI.Button(("Nom: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.lastname)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
                    onSelected = function()
                        local input = _FlashClient_Utils.input_showBox("Nom:", "", 30, false)
                        if (input ~= nil) then
                            local match = _FlashClient_Utils.regex_name(input)
                            if (not (match)) then
                                _FlashClient_Utils.notifications_template_error("Ce nom est incorrect. Assurez vous qu'il commence par une ~y~majuscule")
                            else
                                builder.identity.lastname = input
                                _FlashClient_Utils.notifications_template_success("Prénom enregistré")
                            end
                        end
                    end
                })
                RageUI.Button(("Âge: %s"):format(_FlashClient_Utils.menu_label_valueOrVoid(builder.identity.age)), nil, { RightLabel = _FlashClient_Utils.menu_label_change() }, true, {
                    onSelected = function()
                        local input = _FlashClient_Utils.input_showBox("Âge:", "", 2, true)
                        if (input ~= nil and tonumber(input) ~= nil) then
                            input = tonumber(input)
                            if (input < 18 or input > 99) then
                                _FlashClient_Utils.notifications_template_error("Vous êtes trop jeune ou trop vieux ! Veuillez réessayer")
                            else
                                builder.identity.age = input
                                _FlashClient_Utils.notifications_template_success("Âge enregistré")
                            end
                        end
                    end
                })
            end)
            RageUI.IsVisible(menus[3], function()

            end)
        end
    end)
end)