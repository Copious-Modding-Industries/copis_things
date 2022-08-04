dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local vel_x, vel_y = 0,0
edit_component( entity_id, "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
end)

local init_angle = 0
local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "angle" );
if comp ~= nil then
    init_angle = ComponentGetValue2( comp, "value_int");
end

local angle = init_angle -- math.atan2( vel_y, vel_x )
local length = 1200 * math.random(0.90,1.10)

local iter = ((math.pi * 2)/8) * ((GameGetFrameNum()/4) % 8)
vel_x = math.cos(angle + iter) * length
vel_y = math.sin(angle + iter) * length

local silver_bullet = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/silver_bullet.xml", pos_x, pos_y, vel_x, vel_y )
EntityAddTag( silver_bullet, "projectile_cloned" )


