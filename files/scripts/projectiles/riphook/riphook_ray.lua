dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local length = 1500
local how_many = 0

local vscs = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
for i=1, #vscs do
    if ComponentGetValue2(vscs[i], "name") == "riphook_ray_shot_count" then
        how_many = ComponentGetValue2(vscs[i], "value_int")
        break
    end
end

local angle_inc = math.rad(10)
local angle = how_many * angle_inc / -2
for i=1,how_many do
    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    local function shoot_projectile_from_projectile( who_shot, entity_file, x, y, vel_x, vel_y )
        local entity_id = EntityLoad( entity_file, x, y )
        local herd_id   = get_herd_id( who_shot )
        local entity_that_shot = GetUpdatedEntityID()

        local who_shot_creature = 0
        edit_component( who_shot, "ProjectileComponent", function(comp,vars)
            who_shot_creature = ComponentGetValue2( comp, "mWhoShot" )
            ComponentSetValue2( comp, "mEntityThatShot", entity_that_shot )
        end)


        GameShootProjectile( who_shot_creature, x, y, x+vel_x, y+vel_y, entity_id, true, who_shot )

        edit_component( entity_id, "ProjectileComponent", function(comp,vars)
            vars.mWhoShot       = component_get_value_int( who_shot, "ProjectileComponent", "mWhoShot", 0 )
            vars.mShooterHerdId = component_get_value_int( who_shot, "ProjectileComponent", "mShooterHerdId", 0 )
        end)

        edit_component( entity_id, "VelocityComponent", function(comp,vars)
            ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
        end)

        if EntityHasTag( who_shot, "friendly_fire_enabled" ) then
            EntityAddTag( entity_id, "friendly_fire_enabled" )

            edit_component( entity_id, "ProjectileComponent", function(comp,vars)
                ComponentSetValue2( comp, "friendly_fire", true )
                ComponentSetValue2( comp, "collide_with_shooter_frames", 6 )
            end)
        end

        return entity_id
    end




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