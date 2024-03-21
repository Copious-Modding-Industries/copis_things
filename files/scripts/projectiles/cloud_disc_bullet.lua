dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
for i=1, math.random(0,2) do
	local angle = math.rad(math.random(-75,-105))
	local length = 75
	local vel_x = math.cos( angle ) * length
	local vel_y = 0 - math.sin( angle ) * length
	---@diagnostic disable-next-line: undefined-global  -- todo steal the shoot projectile code
	local eid = shoot_projectile_from_projectile( entity_id, "data/entities/projectiles/deck/disc_bullet.xml", pos_x+math.random(-25,25), pos_y+15, vel_x, vel_y )
end