dofile("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled(entity, "ProjectileComponent");
if projectile ~= nil then
    local shooter = ComponentGetValue2(projectile, "mWhoShot");
    if shooter ~= nil then
        local shooter_x, shooter_y = EntityGetTransform(shooter)
        local delta_x, delta_y = 0, 0
        local proj_x, proj_y = EntityGetTransform(entity)
        local orbitals = EntityGetInRadiusWithTag(proj_x, proj_y, 100, "orbit_shooter")
        for _, orbital in ipairs(orbitals) do
            if orbital ~= entity then
                local orbital_x, orbital_y = EntityGetTransform(orbital)
                local dist = 32 + math.sqrt((orbital_x - proj_x) ^ 2 + (orbital_y - proj_y) ^ 2)
                if dist > 0.1 then
                    local strength = (200 / math.max(dist, 1))^2
                    local angle = math.atan2(orbital_y - proj_y, orbital_x - proj_x)
                    delta_x = delta_x + math.sin(angle) * strength
                    delta_y = delta_y - math.cos(angle) * strength
                end
            end
        end
        local shooter_dist = math.sqrt((shooter_x - proj_x) ^ 2 + (shooter_y - proj_y) ^ 2)
        local force = (shooter_dist - 20) / -2
        local angle = math.atan2(shooter_y - proj_y, shooter_x - proj_x)
        delta_x = delta_x + math.sin(angle) * force
        delta_y = delta_y - math.cos(angle) * force
        local velocity = EntityGetFirstComponentIncludingDisabled(entity, "VelocityComponent");
        if velocity ~= nil then
            local vx, vy = ComponentGetValue2(velocity, "mVelocity");
            ComponentSetValue2(velocity, "mVelocity", vx + delta_x, vy + delta_y);
        end
    end
end