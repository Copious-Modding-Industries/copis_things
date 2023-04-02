local function register_action( state )
    local c = state

    if not reflecting then

        if c.debug == true then

            local types = {
                "ACTION_TYPE_PROJECTILE",
                "ACTION_TYPE_STATIC_PROJECTILE",
                "ACTION_TYPE_MODIFIER",
                "ACTION_TYPE_DRAW_MANY",
                "ACTION_TYPE_MATERIAL",
                "ACTION_TYPE_OTHER",
                "ACTION_TYPE_UTILITY",
                "ACTION_TYPE_PASSIVE",
            }

            c.debug = nil
            print(string.rep("\n", 3))
            print(string.rep("-", 83))


            for key, value in pairs(c) do

                if key == "action_type" then
                    value = types[value+1]
                end

                print(string.format("%-40s | %40s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
            end

            print(string.rep("-", 83))
            print(string.rep("\n", 3))


            for key, value in pairs(current_action) do

                if key == "type" then
                    value = types[value+1]
                end

                print(string.format("%-40s | %40s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
            end

            print(string.rep("-", 83))
            print(string.rep("\n", 3))
        end
    end

    copi_state.old._register_action( c )
    GunUtils.state_per_cast( c )
    return state
end
return {register_action = register_action}