local function draw_actions( how_many, instant_reload_if_empty )
    copi_state.instant_reload_if_empty = instant_reload_if_empty
    copi_state.old._draw_actions( how_many, instant_reload_if_empty );
end
return {draw_actions=draw_actions}