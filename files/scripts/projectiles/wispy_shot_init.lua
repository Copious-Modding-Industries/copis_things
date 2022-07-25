dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

edit_component( entity_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = 0
	vars.penetrate_world = 1
end)
edit_component( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
end)