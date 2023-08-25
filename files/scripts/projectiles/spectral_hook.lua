local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local ent_that_shot = ComponentGetValue2(projcomp, "mEntityThatShot")
if ent_that_shot <= 0 then ent_that_shot = ComponentGetValue2(projcomp, "mWhoShot") end
if EntityGetIsAlive(ent_that_shot) then
    local pos_x, pos_y       = EntityGetTransform(entity_id)
    local target_x, target_y = EntityGetTransform(ent_that_shot)
    local angle              = math.atan2(pos_y - target_y, pos_x - target_x)
    local sprite             = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")
    if sprite then
        ComponentSetValue2(sprite, "rotation", angle)
    end

    -- Particle logic
    local vars = EntityGetComponent(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
    local particle_x, particle_y = (function ()
        local x, y = target_x, target_y
        local inventory = EntityGetFirstComponent(ent_that_shot, "Inventory2Component")
        if inventory then
            local active_wand = ComponentGetValue2(inventory, "mActiveItem")
            if EntityHasTag(active_wand, "wand") then
                local _, _, rot = EntityGetTransform(active_wand)
                local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos") --[[@cast HotspotComponent number]]
                local ox, oy = ComponentGetValueVector2(HotspotComponent, "offset")
                local cosine = math.cos(rot)
                local sine   = math.sin(rot)
                local tip_x = cosine * ox - sine   * oy
                local tip_y = sine   * ox + cosine * oy
                x, y = x + tip_x, y + tip_y - 4
            end
        end
        return x, y
    end)()
    for i = 1, #vars do
        ComponentSetValue2(vars[i], "mExPosition", particle_x, particle_y)
    end

    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    if (vel_x * vel_x) + (vel_y * vel_y) < 400 then
        -- Attractor logic
        local vcomp = EntityGetFirstComponent(ent_that_shot, "VelocityComponent")
        local cdc = EntityGetFirstComponent(ent_that_shot, "CharacterDataComponent")
        if cdc then
            local old_vx, old_vy = ComponentGetValueVector2(cdc, "mVelocity")
            local vx = (pos_x - target_x)
            local vy = (pos_y - target_y)
            local vel = (vx ^ 2 + vy ^ 2) ^ .5
            local vel_cap = math.min(100, vel) -- Please provide feedback on how fast this feels! 150 is a little too strong, but 50 is too gentle imo
            vx = (vx / vel) * vel_cap
            vy = (vy / vel) * vel_cap

            -- Kill if too close + final bonus fling
            if ((pos_x - target_x) ^ 2 + (pos_y - target_y) ^ 2) < 750 then
                EntityAddComponent2(entity_id, "LifetimeComponent", { lifetime = 1 })
                vx = vx * 5.0
                vy = vy * 2.5
                ComponentSetValue2(cdc, "mVelocity", old_vx + vx, old_vy + vy)
            end
            -- Apply velocity
            ComponentSetValue2(cdc, "mVelocity", old_vx + vx, old_vy + vy)

            -- Drag through terrain
            local desired_x, desired_y = target_x + vx / 25, target_y + vy / 25
            EntitySetTransform(ent_that_shot, desired_x, desired_y)
            if RaytracePlatforms(target_x, target_y, desired_x, desired_y) then
                local damage = ((vx * vx) * (vy * vy)) ^ 0.4 * 0.000133 -- Weird special mystical number. It was revealed to me in my dreams.
                EntityInflictDamage(ent_that_shot, damage, "DAMAGE_CURSE", "Dragged straight to hell.", "PLAYER_RAGDOLL_CAMERA", vx, vy, ent_that_shot, desired_x, desired_y, 0)
            end
        elseif vcomp then
            -- Handle projectiles
            local proj_vel_x, proj_vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
            ComponentSetValue2(vcomp, "mVelocity", proj_vel_x + (pos_x - target_x), proj_vel_y + (pos_y - target_y))
        else
            EntityKill(entity_id)
        end
    end
else
    EntityKill(entity_id)
end
