dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local vel_x, vel_y = 0,0

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
end)

local angle = math.atan2( vel_y, vel_x )
local length = 1200 * math.random(0.90,1.10)
local spread_const = 0.523599

-- one side
for i=1,3 do
    local offset = -1.5708 + (spread_const * 2)
    offset = offset - (spread_const * i)
    vel_x = math.cos(angle + offset) * length
    vel_y = math.sin(angle + offset) * length
    local silver_bullet = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
    EntityAddTag( silver_bullet, "projectile_cloned" )
end

-- the other
for i=1,3 do
    local offset = 1.5708 - (spread_const * 2)
    offset = offset + (spread_const * i)
    vel_x = math.cos(angle + offset) * length
    vel_y = math.sin(angle + offset) * length
    local silver_bullet = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
    EntityAddTag( silver_bullet, "projectile_cloned" )
end