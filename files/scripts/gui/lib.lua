function do_custom_tooltip( callback, z, x_offset, y_offset )
    if z == nil then z = -12; end
    local left_click,right_click,hover,x,y,width,height,draw_x,draw_y,draw_width,draw_height = previous_data( gui );
    local screen_width,screen_height = GuiGetScreenDimensions( gui );
    if x_offset == nil then x_offset = 0; end
    if y_offset == nil then y_offset = 0; end
    if draw_y > screen_height * 0.5 then
        y_offset = y_offset - height;
    end
    if hover then
        local screen_width, screen_height = GuiGetScreenDimensions( gui );
        GuiZSet( gui, z );
        GuiLayoutBeginLayer( gui );
            GuiLayoutBeginVertical( gui, ( x + x_offset + width * 2 ) / screen_width * 100, ( y + y_offset ) / screen_height * 100 );
                GuiBeginAutoBox( gui );
                    if callback ~= nil then callback(); end
                    GuiZSetForNextWidget( gui, z + 1 );
                GuiEndAutoBoxNinePiece( gui );
            GuiLayoutEnd( gui );
        GuiLayoutEndLayer( gui );
    end
end