---@diagnostic disable: param-type-mismatch, redundant-parameter
local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0;
    local controls = EntityGetFirstComponent(shooter, "ControlsComponent")
    if controls then
        if ComponentGetValue2( controls, "mButtonDownFire" ) == false then
            local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
            if velocity ~= nil then
                local vx,vy = ComponentGetValue2( velocity, "mVelocity");
                local angle = math.atan2( vy, vx );
                local magnitude = 100;
                ComponentSetValue2( velocity, "mVelocity", math.cos( angle ) * magnitude, math.sin( angle ) * magnitude );
            end
            EntityKill( entity );
        end
    end
end