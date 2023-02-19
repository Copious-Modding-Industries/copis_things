local function register_action( state )
    local c = state

    if not reflecting then
        if c.debug == true then
            c.debug = nil
            print(string.rep("_", 81))

            local types = {
                ACTION_TYPE_PROJECTILE	= 0,
                ACTION_TYPE_STATIC_PROJECTILE = 1,
                ACTION_TYPE_MODIFIER	= 2,
                ACTION_TYPE_DRAW_MANY	= 3,
                ACTION_TYPE_MATERIAL	= 4,
                ACTION_TYPE_OTHER		= 5,
                ACTION_TYPE_UTILITY		= 6,
                ACTION_TYPE_PASSIVE		= 7,
            }

            for key, value in pairs(c) do

                if key == "action_type" then
                    value = types[value]
                end

                print(string.format("%-40s | %40s", tostring(key), tostring(value)))
            end
        end
    end

    copi_state.old._register_action( c )
    GunUtils.state_per_cast( c )
    return state
end
return {register_action = register_action}