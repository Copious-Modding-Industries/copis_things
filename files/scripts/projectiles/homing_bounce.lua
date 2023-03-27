local entity_id = GetUpdatedEntityID()
local bounced_frame = EntityGetFirstComponent(entity_id, "VariableStorageComponent", "bounced_frame")
if bounced_frame ~= nil then
    local value_int = ComponentGetValue2(bounced_frame, "value_int")
    if value_int + 1  == GameGetFrameNum() then
        local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
        if (velcomp ~= nil) then
            -- Get velocity

            local self_x, self_y = EntityGetTransform(entity_id)
            local trgt_id, trgt_dist = nil, math.huge

            local targets = EntityGetInRadiusWithTag(self_x, self_y, 256, "homing_target") or {}
            for i = 1, #targets do
                local trgt_x, trgt_y = EntityGetTransform(targets[i])
                local did_hit = RaytracePlatforms(self_x, self_y, trgt_x, trgt_y)
                if not did_hit then
                    local curr_dist = ((trgt_x - self_x)^2 + (trgt_y - self_y)^2)
                    if curr_dist < trgt_dist then
                        curr_dist = trgt_dist
                        trgt_id = targets[i]
                    end
                end
            end

            if trgt_id ~= nil then
                local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
                SetRandomSeed(GameGetFrameNum(), self_x + self_y + entity_id)
                local trgt_x, trgt_y = EntityGetTransform(trgt_id)

                -- Calculate angle and velocity
                local divergence = ((math.random() - 0.5) * 0.174533)
                local angle = (math.pi - math.atan2((trgt_y - self_y), (trgt_x - self_x))) + divergence
                local length = (vel_x^2 + vel_y^2) ^ 0.5
                print(tostring(length))
                vel_x = -math.cos(angle) * length
                vel_y = math.sin(angle) * length

                -- Set velocity
                ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
            end

        end
    end
end
