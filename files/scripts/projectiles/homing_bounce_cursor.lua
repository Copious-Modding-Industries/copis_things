local entity_id = GetUpdatedEntityID()
local bounced_frame = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounced_frame" )
if bounced_frame ~= nil then
    local value_int = ComponentGetValue2(bounced_frame, "value_int")
    if value_int + 1 == GameGetFrameNum() then
        local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
        if projectilecomp ~= nil then
            local shooter = ComponentGetValue2(projectilecomp, "mWhoShot")
            local ctrlcomp = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
            local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
            if (ctrlcomp ~= nil) and (velcomp ~= nil) then

                -- Get velocity
                local crsr_x, crsr_y = ComponentGetValueVector2(ctrlcomp, "mMousePosition")
                local self_x, self_y = EntityGetTransform( entity_id )
                local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
                SetRandomSeed( GameGetFrameNum(), self_x + self_y + entity_id )

                -- Calculate angle and velocity
                local divergence = ((math.random() - 0.5) * 0.872665)
                local angle = (math.pi - math.atan2( ( crsr_y - self_y ), ( crsr_x - self_x ) )) + divergence
                local length = (vel_x^2 + vel_y^2) ^ 0.5
                vel_x = -math.cos( angle ) * length
                vel_y = math.sin( angle ) * length

                -- Set velocity
                ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
            end
        end
    end
end