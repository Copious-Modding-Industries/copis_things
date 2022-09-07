dofile("data/scripts/lib/utilities.lua")

local function ease_angle( angle, target_angle, easing )
    local dir = ( angle - target_angle ) / (math.pi * 2);
    dir = dir - math.floor( dir + 0.5 );
    dir = dir * ( math.pi * 2 );
    return angle - dir * easing;
end

local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0;
    local control = EntityGetFirstComponent( shooter,"ControlsComponent" );
    if control then
        local mouse_x, mouse_y = ComponentGetValue2( control, "mMousePosition" );
        local x, y = EntityGetTransform( entity );
        local target_angle = math.atan2( mouse_y - y, mouse_x - x );
        local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
        if velocity ~= nil then
            SetRandomSeed( x, y );
            local vx, vy = ComponentGetValue2( velocity, "mVelocity" );
            local angle = math.atan2( vy, vx );
            local magnitude = math.sqrt( vx * vx + vy * vy ) * 1.1 + 1;
            local distance = math.sqrt( math.pow( mouse_x - x, 2 ) + math.pow( mouse_y - y, 2 ) );
            local ease = distance / ( distance + 100 ) + math.sqrt( magnitude ) * 0.02;
            local new_angle = ease_angle( angle, target_angle, math.min( math.max( 0, ease ), 1 ) * Random() );
            ComponentSetValue2( velocity, "mVelocity", math.cos( new_angle ) * magnitude * 0.92, math.sin( new_angle ) * magnitude * 0.92 );
        end
    end
end