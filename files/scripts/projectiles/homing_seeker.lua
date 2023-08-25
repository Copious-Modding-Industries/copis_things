dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
local x, y = self:transform()
local nearby_entities = EntityGetInRadiusWithTag( x, y, 128, "homing_target" ) or {};
local nearest_angle = math.pi / 3;
local target = nil

local entity_id = GetUpdatedEntityID()
local projectile_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
local who_shot = nil
if(projectile_comp)then
    who_shot = ComponentGetValue2( projectile_comp, "mWhoShot" )
end


local function ease_angle( angle, target_angle, easing )
    local dir = (angle - target_angle) / (math.pi*2);
    dir = dir - math.floor(dir + 0.5);
    dir = dir * (math.pi*2);
    return angle - dir * easing;
end

local function angle_difference( target_angle, starting_angle )
    return math.atan2( math.sin( target_angle - starting_angle ), math.cos( target_angle - starting_angle ) );
end

if self.VelocityComponent ~= nil then
    local velocity = self.VelocityComponent.mVelocity
    if velocity.x == 0 and velocity.y == 0 then nearest_angle = math.pi * 2 end
    local velocity_angle = math.atan2( velocity.y, velocity.x );
    for _, entity_id in pairs( nearby_entities ) do
        if(entity_id == who_shot)then
            goto continue
        end
        local ex, ey = EntityGetFirstHitboxCenter(entity_id)
        local target_angle = math.atan2( ey - y, ex - x );
        local angle = math.abs(angle_difference( target_angle, velocity_angle ));
        if angle < nearest_angle then
            nearest_angle = angle;
            target = entity_id;
        end
        ::continue::
    end
    SetRandomSeed( x, y );
    if target ~= nil then
        local projectile = self.ProjectileComponent
        if projectile ~= nil then
            local tx, ty = EntityGetFirstHitboxCenter( target );
            if tx == nil or ty == nil then
                tx, ty = EntityGetTransform( target );
            end
            local time = (GameGetFrameNum() - self.var_int.copis_things_spawn_frame) / 30
            local lifetime_multiplier = math.pow( math.min( 1, time ), 2 );
            local aim_angle = math.atan2( ty - y, tx - x );
            local angle = math.atan2( velocity.y, velocity.x );
            local magnitude = math.sqrt( velocity.x * velocity.x + velocity.y * velocity.y );
            if magnitude == 0 then angle = aim_angle end
            magnitude = magnitude + 1;
            local difference = math.abs( angle_difference( angle, aim_angle ) );
            local new_angle = ease_angle( angle, aim_angle + (Random(-1.0, 1.0) * 15 / 180 * math.pi), ( 0.06 + 0.27 * lifetime_multiplier ) ) + (Random(-1.0, 1.0) * 3 / 180 * math.pi);
            velocity.x = math.cos( new_angle ) * magnitude
            velocity.y = math.sin( new_angle ) * magnitude
        end
    else
        local angle = math.atan2( velocity.y, velocity.x );
        local magnitude = math.sqrt( velocity.x * velocity.x + velocity.y * velocity.y );
        local new_angle = angle + (Random(-1.0, 1.0) * 3 / 180 * math.pi);
        velocity.x = math.cos( new_angle ) * magnitude
        velocity.y = math.sin( new_angle ) * magnitude
    end
    self.VelocityComponent.mVelocity = velocity
end
