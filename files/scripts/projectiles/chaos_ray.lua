dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local projectile_file = ""

local options = {
    "mods/copis_things/files/entities/projectiles/dart.xml",
    "data/entities/projectiles/deck/firebomb.xml",
    "data/entities/projectiles/deck/bullet.xml",
    "data/entities/projectiles/deck/disc_bullet.xml",
    "data/entities/projectiles/deck/light_bullet.xml",
    "data/entities/projectiles/deck/bubbleshot.xml",
    "data/entities/projectiles/deck/arrow.xml",
    "data/entities/projectiles/deck/bullet_heavy.xml",
}

SetRandomSeed( pos_x + GameGetFrameNum(), pos_y + 251 )
local rnd = Random( 1, #options )
projectile_file = options[rnd]

if ( #projectile_file > 0 ) then
	local angle = math.rad(Random(0,359))
	local length = 1500 * (Random(5,15) / 10 )

	local vel_x = math.cos( angle ) * length
	local vel_y = 0 - math.sin( angle ) * length

	local eid = shoot_projectile_from_projectile( entity_id, projectile_file, pos_x, pos_y, vel_x, vel_y )
	EntityAddTag( eid, "projectile_cloned" )
end