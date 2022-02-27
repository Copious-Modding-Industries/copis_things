dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.air_friction= 1200
    vars.mass= 0.05
end)
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = 0
end)
