dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local vel_x, vel_y = 0,0

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
end)

local angle = math.atan2( vel_y, vel_x )
local length = 1200 * math.random(0.90,1.10)

local frame = GameGetFrameNum()
vel_x = math.cos(angle + frame) * length
vel_y = math.sin(angle + frame) * length

local silver_bullet = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
EntityAddTag( silver_bullet, "projectile_cloned" )



-- -110, -90, -70, 70, 90, 110