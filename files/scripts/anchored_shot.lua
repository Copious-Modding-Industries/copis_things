dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
	vars.die_on_low_velocity = 0
end)

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.gravity_x = 0
    vars.air_friction= 0
    vars.mass= 0
 	ComponentSetValueVector2( comp, "mVelocity", 0, 0)
end)
