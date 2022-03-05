dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 96, "homing_target" )

SetRandomSeed( pos_x + pos_y, GameGetFrameNum() )

if ( #targets > 0 ) then
	local rnd = Random(1, #targets)
	local target_id = targets[rnd]
	local target_x, target_y = EntityGetFirstHitboxCenter( target_id )
	local aim_x = target_x - pos_x
	local aim_y = target_y - pos_y
	local len = math.sqrt((aim_x^2) + (aim_y^2))
	local force = 90
	local projectile = "mods/copis_things/files/entities/projectiles/gunner_shot.xml"

	local eid = shoot_projectile_from_projectile( entity_id, projectile, pos_x, pos_y, (aim_x/len*force), (aim_y/len*force) )
	EntityAddTag( eid, "projectile_cloned" )

end

