local function peek_draw_actions( how_many, instant_reload_if_empty )

    -- Save old vars
    local old = {
        _reloading              = reloading,
        _draw_actions_capture   = copi_state.draw_actions_capture,
        _add_projectile         = copi_state._add_projectile,
        _draw_action            = copi_state._draw_action
    }

    -- Increase peeking depth
    copi_state.peeking_depth = copi_state.peeking_depth + 1

    -- make a new capture
    local capture = {}
    local drawn_actions = {}

    -- Replace vars
    copi_state._draw_action = peek_draw_action
    copi_state.old._add_projectile = function( filepath )  end
    copi_state.draw_actions_capture = capture

    -- Draw actions
    draw_actions( how_many, instant_reload_if_empty )
    for capture_index = 1, #capture do
        drawn_actions[#drawn_actions+1] = capture[capture_index]
    end

    -- Reduce peeking depth
    copi_state.peeking_depth = copi_state.peeking_depth - 1

    -- Set old vars
    reloading                       = old._reloading
    copi_state.draw_actions_capture = old._draw_actions_capture
    copi_state.old._add_projectile  = old._add_projectile
    copi_state.old._draw_action     = old._draw_action

    return drawn_actions
end
return {peek_draw_actions}