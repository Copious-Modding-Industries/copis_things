dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	local vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")

	local scale = (math.sin(GameGetFrameNum()) + 1)/2

	GamePrint(scale)

	vel_x = vel_x * scale
	vel_y = vel_y * scale

	ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
end)