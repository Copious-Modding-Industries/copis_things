dofile_once("data/scripts/lib/utilities.lua")
local entity_id     = GetUpdatedEntityID()
local x, y, r       = EntityGetTransform( entity_id )

edit_component( entity_id, "ProjectileComponent", function(comp,vars)
	vars.die_on_low_velocity = 0
    vars.velocity_sets_scale = 0
end)

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.gravity_x = 0
    vars.air_friction= 0
    vars.mass= 0

 	local vel_x, vel_y = ComponentGetValueVector2( comp, "mVelocity")
    vel_x, vel_y = vec_normalize(vel_x, vel_y)
    vel_x, vel_y = vec_mult(vel_x, vel_y, 0.1)
 	ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
end)

local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( variablestorages ~= nil ) then
	for j,storage_id in ipairs(variablestorages) do
		local var_name = ComponentGetValue( storage_id, "name" )
		if ( var_name == "anchor_x" ) then
            ComponentSetValue2( storage_id, "value_float", x)
        elseif ( var_name == "anchor_y" ) then
            ComponentSetValue2( storage_id, "value_float", y)
		end
	end
end