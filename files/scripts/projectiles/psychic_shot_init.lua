dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_x = 0
    vars.gravity_y = 0
    vars.air_friction= 1
    vars.mass= 0.1
end)