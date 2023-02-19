local function draw_action( instant_reload_if_empty )
    local result = false

    copi_state.draw_depth = copi_state.draw_depth + 1
    if copi_state.skip_count <= 0 then
        --for index,extra_modifier in pairs( active_extra_modifiers ) do
        --    handle_extra_modifier( extra_modifier, index, copi_state.draw_action_stack_size )
        --end
        if copi_state.draw_actions_capture ~= nil and copi_state.capture_draw_actions then
            copi_state.draw_actions_capture[#copi_state.draw_actions_capture+1] = deck[1]
        end
        result = copi_state.old._draw_action( instant_reload_if_empty )
    else
        copi_state.skip_count = copi_state.skip_count - 1
        result = true
        -- discard the action
        discarded[#discarded+1] = table.remove( deck, 1 )
    end
    copi_state.draw_depth = copi_state.draw_depth - 1

    if copi_state.draw_depth == 0 then
        GunUtils.state_per_cast( c )
    end

    return result
end
return {draw_action=draw_action}