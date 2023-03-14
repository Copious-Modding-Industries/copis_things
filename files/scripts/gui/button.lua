local function button(Gui, id_fn)
    local screen_w, screen_h = GuiGetScreenDimensions(Gui)
    GuiZSetForNextWidget( Gui, -9001 )
    local lmb = GuiImageButton( Gui, id_fn(), screen_w - 14, 2, "", "mods/copis_things/files/ui_gfx/gui/icon.png" )
    local _, _, hovered, button_x, button_y, button_w, button_h = GuiGetPreviousWidgetInfo(Gui)
    if hovered then
        GuiZSet(Gui, -100)
        GuiOptionsAdd(Gui, 24)
        GuiOptionsAdd(Gui, 23)
        GuiBeginAutoBox(Gui)
        local text_offset_x = button_x + (button_w/2) - 5
        local text_offset_y = button_y + (button_h/2) + 5
            do
                local text = "Configure Copi's Things"
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                win_w = text_width
                GuiText(Gui, text_offset_x - text_width, text_offset_y , text )
            end
            do
                local text = GlobalsGetValue("copis_things_version", "VERSION NOT DECLARED") or "VERSION NOT DECLARED"
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 12 + text_offset_y , text )
            end
            do
                local text = "Menu is WIP. Check mod settings."
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, text_offset_x - text_width, 24 + text_offset_y , text )
            end
        GuiZSet(Gui, -99)
        GuiEndAutoBoxNinePiece(Gui)
        GuiOptionsClear(Gui)
        GuiZSet(Gui, 0)
    end
    return lmb
end
return button