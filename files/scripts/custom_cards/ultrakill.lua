local entity_id = GetUpdatedEntityID()
local wand = EntityGetParent(entity_id)
local shooter = EntityGetRootEntity(entity_id)
local cdcomp = nil
local vscs = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
for i=1, #vscs do
    if ComponentGetValue2(vscs[i], "name") == "cooldown_frame" then
        cdcomp = vscs[i]
        break
    end
end
if cdcomp ~= nil then
    if GameGetFrameNum() >= ComponentGetValue2(cdcomp, "value_int") then
        local controls = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
        local kicks = EntityGetFirstComponentIncludingDisabled(shooter, "KickComponent")
        local abilcomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
        if controls and abilcomp and kicks then
            if ComponentGetValue2(controls, "mButtonFrameKick") == GameGetFrameNum() then
                local multiplier = tonumber( ComponentGetMetaCustom( kicks, "max_force" ) ) / 12
                local x, y = EntityGetTransform(entity_id)
                local projectiles = EntityGetInRadiusWithTag(x, y, 32, "projectile" ) or {}
                local mana = ComponentGetValue2(abilcomp, "mana")
                for i = 1, #projectiles do
                    local projectile = projectiles[i]
                    local projcomp = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
                    local velcomp = EntityGetFirstComponent(projectile, "VelocityComponent")
                    if projcomp and velcomp and mana >= 5 then
                        mana = mana - 5
                        if EntityGetName(projectile) == "coin" then
                            local px, py = EntityGetTransform(projectile)
                            GameCreateSpriteForXFrames( "data/particles/radar_wand_strong.png", px, py )     -- mark hittables
                            local force = ComponentGetValue2(kicks, "max_force") * 50 + 100
                            local damage_buff = ComponentGetValue2(kicks, "max_force")/10

                            local target_x, target_y = ComponentGetValueVector2(controls, "mMousePosition")
                            local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
                            local angle = math.pi - math.atan2( ( target_y - py ), ( target_x - px ) )
                            vel_x = -math.cos( angle ) * force
                            vel_y = math.sin( angle ) * force
                            ComponentSetValue2(velcomp, "terminal_velocity", math.min( ComponentGetValue2(velcomp, "terminal_velocity"), 5000))
                            ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
                            ComponentSetValue2(velcomp, "air_friction", 1)
                            local damage = ComponentGetValue2( projcomp, "damage" )
                            local bounces_left = ComponentGetValue2( projcomp, "bounces_left" )
                            ComponentSetValue2(projcomp, "damage_every_x_frames", 1)
                            ComponentSetValue2(projcomp, "damage", damage + damage_buff )
                            ComponentSetValue2(projcomp, "bounces_left", bounces_left + 1)

                            -- Projectile trail
                            local pecs = EntityGetComponent( projectile, "ParticleEmitterComponent", "grow")
                            if pecs == nil then
                                local pec = EntityAddComponent2( projectile, "ParticleEmitterComponent", {
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
                                ComponentSetValue2( pec, "mExPosition", px, py )
                            end
                        else
                            GameCreateSpriteForXFrames( "data/particles/radar_wand_medium.png", EntityGetTransform(projectile) )     -- mark hittables

                            -- Damage affector for projectile comps
                            if projcomp then
                                -- Set damage
                                ComponentSetValue2(projectile, "damage", ComponentGetValue2(projectile, "damage") * multiplier)
                                -- Set typed damage
                                for _, type in ipairs({"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}) do
                                    local damage = ComponentObjectGetValue2(projectile, "damage_by_type", type)
                                    ComponentObjectSetValue2(projectile, "damage_by_type", type, damage * multiplier)
                                end
                                -- Set explosion damage
                                ComponentObjectSetValue2(projectile, "config_explosion", "damage", ComponentObjectGetValue2(projectile, "config_explosion", "damage") * multiplier)
                            end

                            -- Damage affector for area damage comps
                            local areacomps = EntityGetComponentIncludingDisabled(projcomp, "AreaDamageComponent") or {}
                            for _, areacomp in ipairs(areacomps) do
                                -- Set damage
                                ComponentSetValue2(areacomp, "damage_per_frame", ComponentGetValue2(areacomp, "damage_per_frame") * multiplier);
                            end

                            -- Damage affector for lightning comps
                            local lightning = EntityGetFirstComponentIncludingDisabled(projcomp, "LightningComponent");
                            if lightning then
                                -- Set damage
                                ComponentObjectSetValue2(lightning, "config_explosion", "damage", ComponentObjectGetValue2(lightning, "config_explosion", "damage") * multiplier)
                            end

                            local aim_x, aim_y = ComponentGetValueVector2(controls, "mAimingVectorNormalized")
                            local angle = math.atan2( aim_y, aim_x );
                            local vel_x, vel_y = ComponentGetValueVector2(velcomp, "mVelocity")

                            local magnitude = math.max( math.sqrt( vel_x * vel_x + vel_y * vel_y ) * 1.5, 150 );
                            vel_x = math.cos( angle ) * magnitude
                            vel_y = math.sin( angle ) * magnitude

                            ComponentSetValueVector2(velcomp, "mVelocity", vel_x, vel_y)
                            ComponentSetValue2(projcomp, "friendly_fire", true)
                            ComponentSetValue2(projcomp, "mWhoShot", shooter)
                        end
                    else
                        ComponentSetValue2(abilcomp, "mana", mana)
                        break
                    end
                end
            end
        end
    end
end