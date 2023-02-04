local function button(Gui, id_fn)
    local screen_w, screen_h = GuiGetScreenDimensions(Gui)
    GuiZSetForNextWidget( Gui, -9001 )
    local lmb = GuiImageButton( Gui, id_fn(), screen_w - 14, 2, "", "mods/copis_things/files/ui_gfx/gui/icon.png" )
    local _, _, hovered = GuiGetPreviousWidgetInfo(Gui)
    if hovered then
        local button_x, button_y = screen_w - 14, 2
        local win_x, win_y, win_w, win_h = button_x, button_y, 0, 20
        GuiZSet(Gui, -100)
        GuiOptionsAdd(Gui, 24)
        GuiOptionsAdd(Gui, 23)
        GuiBeginAutoBox(Gui)
            do
                local text = "Configure Copi's Things"
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                win_w = text_width
                GuiText(Gui, (win_w/2) - button_x, 2, text )
            end
            do
                local text = GlobalsGetValue("copis_things_version", "VERSION NOT DECLARED")
                local text_width, text_height = GuiGetTextDimensions(Gui, text)
                GuiColorSetForNextWidget( Gui, 0.5, 0.5, 0.5, 1.0 )
                GuiText(Gui, (win_w/2) - button_x, 16, text )
            end
        GuiZSet(Gui, -99)
        GuiEndAutoBoxNinePiece(Gui)
        GuiOptionsClear(Gui)
        GuiZSet(Gui, 0)
    end
    return lmb
end
return button