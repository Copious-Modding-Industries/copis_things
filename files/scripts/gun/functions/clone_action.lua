local function clone_action(source, target)

    if copi_state.full_clone then
        for key, value in pairs(source) do
            target[key] = value
        end
    else
        copi_state.old._clone_action(instant_reload_if_empty)
    end

end
return { clone_action = clone_action }