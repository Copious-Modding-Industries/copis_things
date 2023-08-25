dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(0,359))
local length = 10

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length

---@diagnostic disable-next-line: undefined-global  -- todo steal the shoot projectile code
local eid = shoot_projectile_from_projectile( entity_id, "data/entities/projectiles/deck/death_cross.xml", pos_x, pos_y, vel_x, vel_y )
EntityAddTag( eid, "projectile_cloned" )
