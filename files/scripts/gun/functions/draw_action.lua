
local function draw_action(instant_reload_if_empty)
    local result = false

    copi_state.draw_depth = copi_state.draw_depth + 1
    if copi_state.skip_count <= 0 then

        if #deck > 0 then
            if copi_state.draw_actions_capture ~= nil then
                copi_state.draw_actions_capture[#copi_state.draw_actions_capture + 1] = deck[1]
            end
            if copi_state.skip_type[deck[1].type] then
                result = true
                discarded[#discarded + 1] = table.remove(deck, 1)
            else
                result = copi_state.old._draw_action(instant_reload_if_empty)
            end
        else
            result = copi_state.old._draw_action(instant_reload_if_empty)
        end

    else
        copi_state.skip_count = copi_state.skip_count - 1
        result = true
        discarded[#discarded + 1] = table.remove(deck, 1)
    end
    copi_state.draw_depth = copi_state.draw_depth - 1

    if copi_state.draw_depth == 0 then
        GunUtils.state_per_cast(c)
    end

    return result
end
return { draw_action = draw_action }