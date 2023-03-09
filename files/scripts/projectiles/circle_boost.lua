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
        local len = 30
        vel_x = (math.cos(rot) * len) + vel_x
        vel_y = (math.sin(rot) * len) + vel_y
        ComponentSetValue2(cdc, "mVelocity", vel_x, vel_y)
    end
end
for i=1, #projectiles do
    if projectiles[i] ~= entity_id then
        local vcomp = EntityGetFirstComponent(projectiles[i], "VelocityComponent")
        if vcomp ~= nil then
            local vel_x, vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
            local len = 30
            vel_x = (math.cos(rot) * len) + vel_x
            vel_y = (math.sin(rot) * len) + vel_y
            ComponentSetValue2(vcomp, "mVelocity", vel_x, vel_y)
        end
    end
end

PhysicsApplyForceOnArea(
    function(entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular)
        local len = 30 * math.random(0.70, 1.30)
        vel_x = (math.cos(rot) * len) + body_vel_x
        vel_y = (math.sin(rot) * len) + body_vel_y

        return body_x, body_y, vel_x, vel_y, 0 -- forcePosX,forcePosY,forceX,forceY,forceAngular
    end,
    0,
    x - radius,
    y - radius,
    x + radius,
    y + radius
)
