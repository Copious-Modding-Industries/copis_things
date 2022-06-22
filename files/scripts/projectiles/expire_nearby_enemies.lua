dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 32, "homing_target" )

if ( #targets > 0 ) then
	EntityKill(entity_id)
end