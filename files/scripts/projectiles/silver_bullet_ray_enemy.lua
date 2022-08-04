dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

local length = 3000

local iter = ((math.pi * 2)/8) * ((GameGetFrameNum()/4) % 8)
local vel_x = math.cos(iter) * length
local vel_y = math.sin(iter) * length

shoot_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )