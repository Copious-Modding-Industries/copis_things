dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(0,359))
local length = 1500
local how_many = 0

local vscs = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
for i=1, #vscs do
    if ComponentGetValue2(vscs[i], "name") == "grappling_hook_shot_count" then
        how_many = ComponentGetValue2(vscs[i], "value_int")
        break
    end
end

local angle_inc = ( math.pi * 2 ) / how_many
for i=1,how_many do
    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    local hook_id = shoot_projectile_from_projectile( entity_id, "mods/copis_things/files/entities/projectiles/grappling_hook.xml", pos_x, pos_y, vel_x, vel_y )
    do -- Get shooter ent
        local vars = EntityGetComponentIncludingDisabled(hook_id, "VariableStorageComponent") or {}
        for j = 1, #vars do
            if ComponentGetValue2(vars[j], "name") == "target_ent" then
                ComponentSetValue2(vars[j], "value_int", entity_id)
            end
        end
    end
    EntityAddTag( hook_id, "projectile_cloned" )
    angle = angle + angle_inc
end