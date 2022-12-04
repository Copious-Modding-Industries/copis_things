dofile("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
EntityAddTag(entity_id, "orbit_shooter")
edit_component2( entity_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = false
	vars.penetrate_world = true
end)
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
end)