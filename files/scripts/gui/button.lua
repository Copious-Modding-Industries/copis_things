local function button(Gui, id_fn)

    if Path == nil then

        local flags = {
            "bonus_copious",
			-- READ THE README
            "sp_nolla",
            "bonus_friendship",
            "purgatory_win",
            "progress_worseenemies",
            "secret_amulet",
            "progress_nightmare",
            "progress_lap2",
            "secret_greed",
            "progress_carnage",
            "progress_ending0",
        }

        local tier = "none"
        for i = 1, #flags do
            if HasFlagPersistent( flags[i] ) then
                tier = flags[i]
                break
            end
        end

        Path = table.concat({"mods/copis_things/files/ui_gfx/gui/badges/", tier, ".png"})
        --Path = table.concat({"mods/copis_things/files/ui_gfx/gui/badges/", flags[((math.floor(GameGetFrameNum()/60)) % #flags) + 1], ".png"})
    end

    -- Path = Path or table.concat({"mods/copis_things/files/ui_gfx/gui/badges/", ModSettingsGet, ".png"})

    local screen_w, screen_h = GuiGetScreenDimensions(Gui)
    GuiZSetForNextWidget( Gui, -9001 )
    local lmb = GuiImageButton( Gui, id_fn(), screen_w - 14, 2, "", "mods/copis_things/files/ui_gfx/gui/icon.png" )
    local _, _, hovered, button_x, button_y, button_w, button_h = GuiGetPreviousWidgetInfo(Gui)
    if hovered then
        GuiZSet(Gui, -100)
        GuiOptionsAdd(Gui, 24)
        GuiOptionsAdd(Gui, 23)
        GuiBeginAutoBox(Gui)
        local text_offset_x = math.floor(button_x + (button_w/2) - 5)
        local text_offset_y = math.floor(button_y + (button_h/2) + 5)
        local window_w = 0
            do
                local text = "Configure Copi's Things"
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                window_w = math.max(window_w, text_width)
                GuiText(Gui, text_offset_x - text_width, text_offset_y , text )
            end
            do
                local text = GlobalsGetValue("copis_things_version", "VERSION NOT DECLARED") or "VERSION NOT DECLARED"
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                window_w = math.max(window_w, text_width)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 12 + text_offset_y , text )
            end
            do
                local text = "Menu is WIP. Check mod settings."
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                window_w = math.max(window_w, text_width)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 24 + text_offset_y , text )
            end
            do
                local text = "DEBUG: Press [P] to spawn a random copi spell."
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                window_w = math.max(window_w, text_width)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 36 + text_offset_y , text )
            end
            do
                local text = "DEBUG: Press [L] to edit wands."
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                window_w = math.max(window_w, text_width)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 48 + text_offset_y , text )
            end
            do
                local im_w, im_h = GuiGetImageDimensions(Gui, Path)
                GuiOptionsAddForNextWidget(Gui, 22)
                GuiImage(Gui, id_fn(), text_offset_x - window_w, text_offset_y, Path, 1, 1, 1)
            end
        GuiZSet(Gui, -99)
        GuiEndAutoBoxNinePiece(Gui)
        GuiOptionsClear(Gui)
        GuiZSet(Gui, 0)
    end
    return lmb
end
return button