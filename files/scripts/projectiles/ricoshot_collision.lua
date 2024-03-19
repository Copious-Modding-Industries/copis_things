function collision_trigger( colliding_entity_id )

    if EntityGetName(colliding_entity_id) == "coin" then
        return
    end

    local self_id = GetUpdatedEntityID()
    local shooter = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(self_id, "ProjectileComponent"), "mWhoShot")
    local coin_x, coin_y = EntityGetTransform(self_id)
    local target_data = {
        distance = math.huge,
        id = nil
    }

    -- Scan for coins
    if target_data.id == nil then
        local targets = EntityGetInRadiusWithTag(coin_x, coin_y, 128, "projectile")
        for _, target in ipairs(targets) do
            if EntityGetName(target) == "coin" and target ~= self_id then
                local projcomp = EntityGetFirstComponentIncludingDisabled(colliding_entity_id, "ProjectileComponent")
                if ComponentGetValue2(projcomp, "mWhoShot") == shooter then
                    local target_x, target_y = EntityGetTransform(target)
                    local did_hit = RaytraceSurfaces(coin_x, coin_y, target_x, target_y)
                    if not did_hit then
                        local distance = (target_x - coin_x)^2 + (target_y - coin_y)^2
                        if distance < target_data.distance then
                            target_data.id = target
                        end
                    end
                end
            end
        end
    end

    -- Scan for enemies fallback
    if target_data.id == nil then
        local targets = EntityGetInRadiusWithTag(coin_x, coin_y, 128, "enemy")
        for _, target in ipairs(targets) do
            local target_x, target_y = EntityGetTransform(target)
            local distance = (target_x - coin_x)^2 + (target_y - coin_y)^2
            if distance < target_data.distance then
                target_data.id = target
            end
        end
    end

    -- Target location
    local target_x, target_y = 0, 0
    local projectile_x, projectile_y = EntityGetTransform(colliding_entity_id)
    if target_data.id ~= nil then
        target_x, target_y = EntityGetTransform(target_data.id)
        local did_hit, ray_x, ray_y = RaytracePlatforms(projectile_x, projectile_y, target_x, target_y)
        if did_hit then
            target_x = ray_x
            target_y = ray_y
        end
    else
        target_x = math.random(-128, 128) + projectile_x
        target_y = math.random(-128, 128) + projectile_y
        local did_hit, ray_x, ray_y = RaytracePlatforms(projectile_x, projectile_y, target_x, target_y)
        if did_hit then
            target_x = ray_x
            target_y = ray_y
        end
    end

    -- Projectile trail
    local pecs = EntityGetComponent(colliding_entity_id, "ParticleEmitterComponent", "grow")
    if pecs == nil then
        local pec = EntityAddComponent2( colliding_entity_id, "ParticleEmitterComponent", {
            emitted_material_name="spark",
            is_trail = true,
            fade_based_on_lifetime = true,
            create_real_particles = false,
            emit_cosmetic_particles = true,
            count_min=1,
            count_max=1,
            lifetime_min=0.1,
            lifetime_max=0.1,
            emission_interval_min_frames=1,
            emission_interval_max_frames=1,
            is_emitting=true,
            trail_gap=1
        })
        ComponentAddTag( pec, "grow")
        ComponentSetValue2( pec, "gravity", 0.0, 0.0 )
        ComponentSetValue2( pec, "mExPosition", coin_x, coin_y )
    end

    local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
    local projcomp = EntityGetFirstComponentIncludingDisabled(colliding_entity_id, "ProjectileComponent")
    if ComponentGetValue2(projcomp, "collide_with_world") then
        EntityAddComponent2(colliding_entity_id, "LuaComponent", {
            script_source_file = "mods/copis_things/files/scripts/projectiles/ricoshot_collide_hax.lua",
            remove_after_executed = true,
            execute_every_n_frame = 1,
        })
        ComponentSetValue2(projcomp, "collide_with_world", false)
    end

    ComponentSetValue2(projcomp, "penetrate_entities", true)
    ComponentSetValue2(projcomp, "mWhoShot", shooter)
    local damage = ComponentGetValue2( projcomp, "damage" )
    ComponentSetValue2( projcomp, "damage", damage * 1.5 )
    for _, type in ipairs(damage_types) do
        local type_damage = ComponentObjectGetValue2(projcomp, "damage_by_type", type)
        ComponentObjectSetValue2(projcomp, "damage_by_type", type, type_damage * 1.5)
    end

    local velcomp = EntityGetFirstComponent(colliding_entity_id, "VelocityComponent")
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    local angle = math.pi - math.atan2( ( target_y - coin_y ), ( target_x - coin_x ) )
    local ca = math.cos(angle)
    local sa = math.sin(angle)
    vel_x = (ca * vel_x - sa * vel_y)
    vel_y = (sa * vel_x + ca * vel_y)
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)

    EntitySetTransform( colliding_entity_id, target_x, target_y)
    EntityKill(self_id)
end