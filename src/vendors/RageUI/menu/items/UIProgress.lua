---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUI
---


---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "root_cause", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

local SettingsProgress = {
    Background = { X = 8, Y = 33, Width = 415, Height = 20 },
    Bar = { X = 11.75, Y = 36.75, Width = 407.5, Height = 12.5 },
    Height = 60
}

---@type table Index of all List Items
local Index = { }

---@type Item
function RageUI.Item.Progress(Label, Items, StartedAtIndex, Description, Counter, Enabled, Actions)

    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() then


            ---@type number
            local Option = RageUI.Options + 1

            if (Index[Option] == nil) then
                Index[Option] = { Current = StartedAtIndex }
            end

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local ProgressHovered = false

                RageUI.ItemsSafeZone(CurrentMenu)

                local Hovered = false;

                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                local ProgressText = (Counter and Index[Option].Current .. "/" .. #Items or (type(Items[Index[Option].Current]) == "table") and tostring(Items[Index[Option].Current].Name) or tostring(Items[Index[Option].Current]))

                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsProgress.Height)
                    ProgressHovered = RageUI.IsMouseInBounds(CurrentMenu.X + SettingsProgress.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsProgress.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 12, SettingsProgress.Bar.Width + CurrentMenu.WidthOffset, SettingsProgress.Bar.Height + 24)
                end

                if Enabled == true or Enabled == nil then
                    if Selected then
                        RenderText(ProgressText, CurrentMenu.X + SettingsButton.RightText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)

                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)

                        RenderRectangle(CurrentMenu.X + SettingsProgress.Background.X, CurrentMenu.Y + SettingsProgress.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsProgress.Background.Width + CurrentMenu.WidthOffset, SettingsProgress.Background.Height, 0, 0, 0, 255)
                        RenderRectangle(CurrentMenu.X + SettingsProgress.Bar.X, CurrentMenu.Y + SettingsProgress.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, ((Index[Option].Current / #Items) * (SettingsProgress.Bar.Width + CurrentMenu.WidthOffset)), SettingsProgress.Bar.Height, 240, 240, 240, 255)
                    else
                        RenderText(ProgressText, CurrentMenu.X + SettingsButton.RightText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)

                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)

                        RenderRectangle(CurrentMenu.X + SettingsProgress.Background.X, CurrentMenu.Y + SettingsProgress.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsProgress.Background.Width + CurrentMenu.WidthOffset, SettingsProgress.Background.Height, 240, 240, 240, 255)
                        RenderRectangle(CurrentMenu.X + SettingsProgress.Bar.X, CurrentMenu.Y + SettingsProgress.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, ((Index[Option].Current / #Items) * (SettingsProgress.Bar.Width + CurrentMenu.WidthOffset)), SettingsProgress.Bar.Height, 0, 0, 0, 255)
                    end
                else
                    RenderText(ProgressText, CurrentMenu.X + SettingsButton.RightText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.RightText.Scale, 163, 159, 148, 255, 2)

                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
                    if Selected then
                        RenderRectangle(CurrentMenu.X + SettingsProgress.Background.X, CurrentMenu.Y + SettingsProgress.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsProgress.Background.Width + CurrentMenu.WidthOffset, SettingsProgress.Background.Height, 0, 0, 0, 255)
                    else
                        RenderRectangle(CurrentMenu.X + SettingsProgress.Background.X, CurrentMenu.Y + SettingsProgress.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsProgress.Background.Width + CurrentMenu.WidthOffset, SettingsProgress.Background.Height, 240, 240, 240, 255)
                    end
                end

                RageUI.ItemOffset = RageUI.ItemOffset + SettingsProgress.Height

                RageUI.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and CurrentMenu.Controls.Left.Active and not CurrentMenu.Controls.Right.Active then
                    Index[Option].Current = Index[Option].Current - 1

                    if Index[Option].Current < 0 then
                        Index[Option].Current = #Items
                    end
                    if (Actions.onListChange ~= nil) then
                        Citizen.CreateThread(function()
                            Actions.onListChange(Index[Option].Current);
                        end)
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and CurrentMenu.Controls.Right.Active and not CurrentMenu.Controls.Left.Active then
                    Index[Option].Current = Index[Option].Current + 1
                    if Index[Option].Current > #Items then
                        Index[Option].Current = 0
                    end
                    if (Actions.onListChange ~= nil) then
                        Citizen.CreateThread(function()
                            Actions.onListChange(Index[Option].Current);
                        end)
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and not ProgressHovered)) then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                    if (Actions.onSelected ~= nil) then
                        Citizen.CreateThread(function()
                            Actions.onSelected(Index[Option].Current);
                        end)
                    end
                elseif Selected and (Hovered and CurrentMenu.Controls.Click.Active and ProgressHovered) then

                    ---@type number
                    local Progress = (math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X) - SettingsProgress.Bar.X

                    ---@type number
                    local Barsize = SettingsProgress.Bar.Width + CurrentMenu.WidthOffset

                    if Progress > Barsize then
                        Progress = Barsize
                    elseif Progress < 0 then
                        Progress = 0
                    end

                    Index[Option].Current = math.round(#Items * (Progress / Barsize))

                    if Index[Option].Current > #Items or Index[Option].Current < 0 then
                        Index[Option].Current = 0
                    end

                end

                if (Hovered) then
                    if (Actions.onHovered ~= nil) then
                        Actions.onHovered();
                    end
                end

            end
            RageUI.Options = RageUI.Options + 1

            Items = nil
        end
    end
end


