dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	local vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")

	vel_x = 0
	vel_y = vel_y

	ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
end)