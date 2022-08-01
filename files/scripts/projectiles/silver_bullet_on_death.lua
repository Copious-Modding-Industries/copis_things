dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(0,359))
local length = 1500
local how_many = 8
local angle_inc = ( math.pi * 2 ) / how_many

for i=1,how_many do
    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    local eid = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
    EntityAddTag( eid, "projectile_cloned" )
    angle = angle + angle_inc
end

--[[
local angle = 0
local length = 1500

local found_normal,nx,ny,dist = GetSurfaceNormal( pos_x, pos_y, 4, 8 )
if found_normal then
    dist = dist*-1
    local x = pos_x + nx * dist
    local y = pos_y + ny * dist
    angle = math.atan2( y, x )
else
    angle = math.rad(Random(0,359))
end


for i=1,4 do
    local offset = 1.5708 - (0.261799 * 2.5)
    offset = offset + (0.261799 * i)
    local vel_x = math.cos(angle + offset) * length
    local vel_y = math.sin(angle + offset) * length
    local silver_bullet = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
    EntityAddTag( silver_bullet, "projectile_cloned" )
end


local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length
local eid = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
EntityAddTag( eid, "projectile_cloned" )]]