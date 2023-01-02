
local self_id = GetUpdatedEntityID()
local coin_x, coin_y = EntityGetTransform(self_id)
local players = EntityGetInRadiusWithTag(coin_x, coin_y, 16, "player_unit")

if players ~= nil then
    local controls = EntityGetFirstComponentIncludingDisabled(players[1], "ControlsComponent")
    if (ComponentGetValue2(controls, "mButtonFrameKick") == GameGetFrameNum()) then
        local kickcomp = EntityGetFirstComponentIncludingDisabled(players[1], "KickComponent")
        local force = ComponentGetValue2(kickcomp, "max_force") * 50
        local damage_buff = ComponentGetValue2(kickcomp, "max_force")/10

        local target_x, target_y = DEBUG_GetMouseWorld()
        local velcomp = EntityGetFirstComponent(self_id, "VelocityComponent")
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
        local angle = math.pi - math.atan2( ( target_y - coin_y ), ( target_x - coin_x ) )
        vel_x = -math.cos( angle ) * force
        vel_y = math.sin( angle ) * force
        ComponentSetValue2(velcomp, "terminal_velocity", math.min( ComponentGetValue2(velcomp, "terminal_velocity"), 5000))
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
        ComponentSetValue2(velcomp, "air_friction", 1)
        local projcomp = EntityGetFirstComponentIncludingDisabled(self_id, "ProjectileComponent")
        local damage = ComponentGetValue2( projcomp, "damage" )
        local bounces_left = ComponentGetValue2( projcomp, "bounces_left" )
        ComponentSetValue2(projcomp, "damage_every_x_frames", 1)
        ComponentSetValue2( projcomp, "damage", damage + damage_buff )
        ComponentSetValue2(projcomp, "bounces_left", bounces_left + 1)

        -- Projectile trail
        local pecs = EntityGetComponent(self_id, "ParticleEmitterComponent", "grow")
        if pecs == nil then
            local pec = EntityAddComponent2( self_id, "ParticleEmitterComponent", {
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

    end
end