local function draw_actions( how_many, instant_reload_if_empty )
    copi_state.instant_reload_if_empty = instant_reload_if_empty
    if not copi_state.draw_cancel then
        copi_state.old._draw_actions( how_many, instant_reload_if_empty );    
    end
end
return {draw_actions=draw_actions}