dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local player = EntityGetWithTag("player_unit")[1]

local controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
if controls ~= nil then
    local mouse_x, mouse_y = ComponentGetValue2(controls, "mMousePosition")

    local speed = 400

    edit_component2( entity_id, "VelocityComponent", function(comp,vars)
        local vel_x, vel_y = ComponentGetValue2( comp, "mVelocity")

        local len = math.pow((mouse_x*mouse_x) + (mouse_y*mouse_y), 0.3)

        local force_x = vel_x + (mouse_x-pos_x)/len * speed
        local force_y = vel_y + (mouse_y-pos_y)/len * speed

        if get_magnitude(force_x, force_y) >= 400 then
            force_x, force_y = vec_normalize(force_x, force_y)
            force_x, force_y = vec_mult(force_x, force_y, 400)
        end

        ComponentSetValueVector2( comp, "mVelocity", force_x, force_y)
    end)
end