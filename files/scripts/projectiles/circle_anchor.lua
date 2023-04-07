dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(entity_id)
local radius = 14

local hittables = EntityGetInRadiusWithTag(x, y, radius*2, "hittable") or {}
local projectiles = EntityGetInRadiusWithTag(x, y, radius*2, "projectile") or {}

for i=1, #hittables do
    local cdc = EntityGetFirstComponent(hittables[i], "CharacterDataComponent")
    if cdc ~= nil then
        local vel_x, vel_y = ComponentGetValueVector2(cdc, "mVelocity")
        local grav_y = ComponentGetValueVector2(cdc, "gravity")
        vel_x = vel_x/2
        vel_y = vel_y/2 - grav_y
        ComponentSetValue2(cdc, "mVelocity", vel_x, vel_y)
    end
end
for i=1, #projectiles do
    if projectiles[i] ~= entity_id then
        local vcomp = EntityGetFirstComponent(projectiles[i], "VelocityComponent")
        if vcomp ~= nil then
            local vel_x, vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
            local grav_y = ComponentGetValueVector2(vcomp, "gravity_y")
            local mass = ComponentGetValueVector2(vcomp, "mass")
            vel_x = vel_x/2
            vel_y = vel_y/2 - (grav_y * mass)
            ComponentSetValue2(vcomp, "mVelocity", vel_x, vel_y)
        end
    end
end

PhysicsApplyForceOnArea(
    function(entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular)
        return body_x, body_y, body_vel_x/2, body_vel_y/2 -body_mass*9.8, -body_vel_angular/2 -- forcePosX,forcePosY,forceX,forceY,forceAngular
    end,
    0,
    x - radius,
    y - radius,
    x + radius,
    y + radius
)