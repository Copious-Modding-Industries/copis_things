local seek_distance = 128;
local entity = GetUpdatedEntityID();
local x, y  = EntityGetTransform( entity );
local nearby_entities = EntityGetInRadiusWithTag( x, y, seek_distance, "homing_target" ) or {};
local target = nil;
local nearest_distance = seek_distance;
-- setting nearest_angle to less than pi will effectively limit the projectiles line of sight to a certain cone in front of it
local nearest_angle = math.pi / 3;
local function angle_difference( target_angle, starting_angle )
    return math.atan2( math.sin( target_angle - starting_angle ), math.cos( target_angle - starting_angle ) );
end
local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity ~= nil then
    local vx, vy = ComponentGetValue2( velocity, "mVelocity" );
    local velocity_angle = math.atan2( vy, vx );
    if vx == 0 and vy == 0 then
        nearest_angle = math.pi * 2;
    end

    for _,test_entity in pairs( nearby_entities ) do
        local ex, ey = EntityGetTransform( test_entity );
        local target_angle = math.atan2( ey - y, ex - x );
        local angle = math.abs(angle_difference( target_angle, velocity_angle ));
        if angle < nearest_angle then
            nearest_angle = angle;
            target = test_entity;
        end
    end
    local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
    if velocity ~= nil then
        SetRandomSeed( x, y );
        if target ~= nil then
            local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
            if projectile ~= nil then
                local tx, ty = EntityGetFirstHitboxCenter( target );
                if tx == nil or ty == nil then
                    tx, ty = EntityGetTransform( target );
                end

                local comp = EntityGetFirstComponent( entity, "VariableStorageComponent", "spawn_frame" );
                if comp ~= nil then
                    local frame = ComponentGetValue2( comp, "value_int" )
                    local lifetime_multiplier = math.pow( math.min( 1, ( GameGetFrameNum() - frame ) / 5  ), 2 );
                    vx, vy = ComponentGetValue2( velocity, "mVelocity" );
                    local aim_angle = math.atan2( ty - y, tx - x );
                    local angle = math.atan2( vy, vx );
                    local magnitude = math.sqrt( vx * vx + vy * vy );
                    if magnitude == 0 then
                        angle = aim_angle;
                    end
                    magnitude = magnitude + 1;
                    local dir = (angle - aim_angle + (Random(-1.0, 1.0) * 15 / 180 * math.pi)) / (math.pi*2);
                    dir = dir - math.floor(dir + 0.5);
                    dir = dir * (math.pi*2);
                    local new_angle = (angle - dir * ( 0.06 + 0.27 * lifetime_multiplier )) + (Random(-1.0, 1.0) * 3 / 180 * math.pi);

                    ComponentSetValue2( velocity, "mVelocity", math.cos( new_angle ) * magnitude, math.sin( new_angle ) * magnitude );
                end

            end
        else
            local vx, vy = ComponentGetValue2( velocity, "mVelocity" );
            local magnitude = math.sqrt( vx * vx + vy * vy );
            local angle = math.atan2( vy, vx );
            local new_angle = angle + (Random(-1.0, 1.0) * 3 / 180 * math.pi);
            ComponentSetValue2( velocity, "mVelocity", math.cos( new_angle ) * magnitude, math.sin( new_angle ) * magnitude );
        end
    end
end