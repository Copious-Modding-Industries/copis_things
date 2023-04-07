dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

local length = 3000

local iter = ((math.pi * 2)/8) * ((GameGetFrameNum()/4) % 8)
local vel_x = math.cos(iter) * length
local vel_y = math.sin(iter) * length

local hook_id = shoot_projectile( entity_id, "mods/copis_things/files/entities/projectiles/grappling_hook.xml", pos_x, pos_y, vel_x, vel_y )
do -- Get shooter ent
    local projectile = EntityGetFirstComponentIncludingDisabled(hook_id, "ProjectileComponent")
    if projectile ~= nil then
        ComponentSetValue2(projectile, "lifetime", 360);
        EntityRemoveTag(projectile, "projectile_player") -- lagproofing
    end
    local vars = EntityGetComponentIncludingDisabled(hook_id, "VariableStorageComponent") or {}
    for j = 1, #vars do
        if ComponentGetValue2(vars[j], "name") == "target_ent" then
            ComponentSetValue2(vars[j], "value_int", entity_id)
        end
    end
end