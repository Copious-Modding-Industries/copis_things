local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projcomp then
    local target = -420
    do -- Get shooter ent
        local vars = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
        for i = 1, #vars do
            if ComponentGetValue2(vars[i], "name") == "target_ent" then
                target = ComponentGetValue2(vars[i], "value_int")
                if target == -420 then
                    local ent_that_shot = ComponentGetValue2(projcomp, "mEntityThatShot")
                    if ent_that_shot ~= 0 then
                        target = ent_that_shot
                    else
                        target = ComponentGetValue2(projcomp, "mWhoShot")
                    end
                    ComponentSetValue2(vars[i], "value_int", target)
                end
            end
        end
    end

    if target ~= -420 and EntityGetIsAlive(target) then
        local target_x, target_y = EntityGetTransform(target)
        local vtarget_x, vtarget_y = target_x, target_y
        local inventory = EntityGetFirstComponent(target, "Inventory2Component")
        if inventory then
            local active_wand = ComponentGetValue2(inventory, "mActiveItem")
            if EntityHasTag(active_wand, "wand") then
                local _, _, rot = EntityGetTransform(active_wand)
                local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos")
                if HotspotComponent then
                    local ox, oy = ComponentGetValueVector2(HotspotComponent, "offset")
                    local tx = math.cos(rot) * ox - math.sin(rot) * oy
                    local ty = math.sin(rot) * ox + math.cos(rot) * oy
                    vtarget_x, vtarget_y = vtarget_x + tx, vtarget_y + ty
                end
            end
        end
        -- Particle logic
        local vars = EntityGetComponent(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
        for i = 1, #vars do
            if target_x and target_y then
                ComponentSetValue2(vars[i], "mExPosition", vtarget_x, vtarget_y)
            end
        end
        -- Hooking logic
        local pos_x, pos_y, angle = EntityGetTransform(entity_id)
        --local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 2, "hittable") or {} TODO: Stick to entities
        local found_normal, nx, ny, dist = GetSurfaceNormal(pos_x, pos_y, 2, 8)
        if found_normal then
            local angle_new = math.atan2(pos_y - target_y, pos_x - target_x);
            angle = (angle + angle_new) / 2
            EntitySetTransform(entity_id, pos_x + nx * dist, pos_y + ny * dist, angle)

            -- Attractor logic
            local vcomp = EntityGetFirstComponent(target, "VelocityComponent")
            local cdc = EntityGetFirstComponent(target, "CharacterDataComponent")
            if cdc then
                local old_vx, old_vy = ComponentGetValueVector2(cdc, "mVelocity")
                local vx = (pos_x - target_x)
                local vy = (pos_y - target_y)
                local vel = (vx ^ 2 + vy ^ 2) ^ .5
                local vel_cap = math.min(150, vel) -- Please provide feedback on how fast this feels! 250 is a little too strong, but 50 is too gentle imo
                vx = (vx / vel) * vel_cap
                vy = (vy / vel) * vel_cap
                if ((pos_x - target_x) ^ 2 + (pos_y - target_y) ^ 2) < 750 then
                    -- Hook lifetime behaviour
                    EntityAddComponent2(entity_id, "LifetimeComponent", { lifetime = 1 })
                    -- Last fling :troll:
                    vx = vx * 12
                    vy = vy * 12
                end
                ComponentSetValue2(cdc, "mVelocity", old_vx + vx, old_vy + vy)
            elseif vcomp then
                local vel_x, vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
                ComponentSetValue2(vcomp, "mVelocity", vel_x + (pos_x - target_x), vel_y + (pos_y - target_y))
            end
        end
    end
end
