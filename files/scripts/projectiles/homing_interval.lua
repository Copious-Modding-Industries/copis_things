local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
if (velcomp ~= nil) then
    -- Get velocity

    local self_x, self_y = EntityGetTransform(entity_id)
    local trgt_id, trgt_dist = nil, math.huge

    local projectile_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
    local who_shot = nil
    if(projectile_comp)then
        who_shot = ComponentGetValue2( projectile_comp, "mWhoShot" )
    end

    local targets = EntityGetInRadiusWithTag(self_x, self_y, 256, "homing_target") or {}
    for i = 1, #targets do
        if(targets[i] == who_shot)then
            goto continue
        end
        local trgt_x, trgt_y = EntityGetTransform(targets[i])
        local did_hit = RaytracePlatforms(self_x, self_y, trgt_x, trgt_y)
        if not did_hit then
            local curr_dist = ((trgt_x - self_x) ^ 2 + (trgt_y - self_y) ^ 2)
            if curr_dist < trgt_dist then
                curr_dist = trgt_dist
                trgt_id = targets[i]
            end
        end
        ::continue::
    end

    if trgt_id ~= nil then
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
        local trgt_x, trgt_y = EntityGetTransform(trgt_id)

        -- Calculate angle and velocity
        local angle = (math.pi - math.atan2((trgt_y - self_y), (trgt_x - self_x)))
        local length = (vel_x ^ 2 + vel_y ^ 2) ^ 0.5
        vel_x = -math.cos(angle) * length
        vel_y = math.sin(angle) * length

        -- Set velocity
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
    end
end
