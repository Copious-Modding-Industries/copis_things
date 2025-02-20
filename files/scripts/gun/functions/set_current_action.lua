---@diagnostic disable: lowercase-global, undefined-global
--[[local function set_current_action( action )
    if not reflecting then
        action.description = c.action_description or ""
    end
    copi_state.old._set_current_action( action )
end]]



local function set_current_action( action )
    copi_state.old._set_current_action( action )
    c.action_description =			reflecting and action.description				or c.action_description
	current_action = action
end

return {set_current_action = set_current_action}