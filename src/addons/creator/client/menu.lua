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

    },

    outfit = _ConfigClient.Creator.defaultOutFits[1]
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
    local character_sex = RageUI.CreateSubMenu(character, title, desc, nil, nil, "root_cause", "black_red")
    local character_component = RageUI.CreateSubMenu(character, title, desc, nil, nil, "root_cause", "black_red")
    character_component.Closed = function()
        for _, component in pairs(_ConfigClient.Skin) do
            _FlashClient_SkinChanger.applySkin({ [component.id] = builder.skin[component.id] })
            if (component.sub ~= nil) then
                _FlashClient_SkinChanger.applySkin({ [component.sub] = builder.skin[component.sub] })
            end
        end
        ClearPedProp(PlayerPedId(), 1)
    end
    local character_component_variation = RageUI.CreateSubMenu(character_component, title, desc, nil, nil, "root_cause", "black_red")
    character_component_variation.Closed = function()
        for _, component in pairs(_ConfigClient.Skin) do
            _FlashClient_SkinChanger.applySkin({ [component.id] = builder.skin[component.id] })
            if (component.sub ~= nil) then
                _FlashClient_SkinChanger.applySkin({ [component.sub] = builder.skin[component.sub] })
            end
        end
        ClearPedProp(PlayerPedId(), 1)
    end
    return ({ main, identity, character, character_sex, character_component, character_component_variation })
end

local function applySex(currentSex, sexId)
    if (currentSex == sexId) then
        return
    end
    builder.skin["sex"] = sexId
    local model = (sexId == 0 and "mp_m_freemode_01" or "mp_f_freemode_01")
    _FlashClient_Utils.memory_load(model)
    SetPlayerModel(PlayerId(), GetHashKey(model))
    _FlashClient_SkinChanger.setAllToDefault()
    for _, component in pairs(_ConfigClient.Skin) do
        builder.skin[component.id] = 0
        if (component.sub ~= nil) then
            builder.skin[component.sub] = 0
        end
    end
    _FlashClient_SkinChanger.setCharacterValueWithoutChange("sex", sexId)
    _FlashClient_Utils.ped_scenario(PlayerPedId(), "WORLD_HUMAN_GUARD_STAND_CLUBHOUSE", false)
end

_FlashLand.onReceive("creator:initMenu", function()
    _FlashClient_Menu.tryOpenMenu(function()
        local selectedComponent, selectedComponentMax, selectedComponentData = 0, 0, {}
        local menus = createMenus()
        _FlashClient_SkinChanger.setAllToDefault()
        for _, component in pairs(_ConfigClient.Skin) do
            builder.skin[component.id] = _FlashClient_SkinChanger.getCharacter()[component.id]
        end
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
                    RageUI.Button("Sélection du sexe", nil, { RightLabel = "→→" }, true, {}, menus[4])
                    RageUI.Line()
                    for _, component in pairs(_ConfigClient.Skin) do
                        RageUI.Button(("Customisation: ~y~%s"):format(component.label), nil, { RightLabel = "→" }, true, {
                            onSelected = function()
                                selectedComponentData = component
                                selectedComponent = component.id
                                selectedComponentMax = tonumber(_FlashClient_SkinChanger.getMaxValues()[component.id])
                                for k, v in pairs(_ConfigClient.Skin) do
                                    _FlashClient_SkinChanger.setCharacterValueWithoutChange(v.id, builder.skin[v.id])
                                end
                            end
                        }, menus[5])
                    end
                end)
                RageUI.IsVisible(menus[4], function()
                    local sex = _FlashClient_SkinChanger.getCharacter()["sex"]
                    RageUI.Button(("%sHomme"):format(_FlashClient_Utils.menu_display_greenIfTrue(sex == 0)), nil, { RightLabel = _FlashClient_Utils.menu_label_select() }, true, {
                        onSelected = function()
                            applySex(sex, 0)
                        end
                    })
                    RageUI.Button(("%sFemme"):format(_FlashClient_Utils.menu_display_greenIfTrue(sex == 1)), nil, { RightLabel = _FlashClient_Utils.menu_label_select() }, true, {
                        onSelected = function()
                            applySex(sex, 1)
                        end
                    })
                end)
                RageUI.IsVisible(menus[5], function()
                    for i = 0, selectedComponentMax do
                        RageUI.Button(("Type n°~y~%s"):format(i), nil, { RightLabel = _FlashClient_Utils.menu_label_selectOrSelected(builder.skin[selectedComponent] == i) }, true, {
                            onSelected = function()
                                builder.skin[selectedComponent] = i
                            end,
                            onActive = function()
                                if (_FlashClient_SkinChanger.getCharacter()[selectedComponent] ~= i) then
                                    _FlashClient_SkinChanger.applySkin({ [selectedComponent] = i })
                                    ClearPedProp(PlayerPedId(), 0)
                                    ClearPedProp(PlayerPedId(), 1)
                                end
                            end
                        }, (selectedComponentData.sub ~= nil and menus[6] or nil))
                    end
                end)
                RageUI.IsVisible(menus[6], function()
                    for i = 0, _FlashClient_SkinChanger.getMaxValues()[selectedComponentData.sub] do
                        RageUI.Button(("Variation n°~y~%s"):format(i), nil, { RightLabel = _FlashClient_Utils.menu_label_selectOrSelected(builder.skin[selectedComponentData.sub] == i) }, true, {
                            onSelected = function()
                                builder.skin[selectedComponentData.sub] = i
                            end,
                            onActive = function()
                                if (_FlashClient_SkinChanger.getCharacter()[selectedComponentData.sub] ~= i) then
                                    _FlashClient_SkinChanger.applySkin({ [selectedComponentData.sub] = i })
                                    ClearPedProp(PlayerPedId(), 0)
                                    ClearPedProp(PlayerPedId(), 1)
                                end
                            end
                        })
                    end
                end)
            end
        end)
    end)
end)