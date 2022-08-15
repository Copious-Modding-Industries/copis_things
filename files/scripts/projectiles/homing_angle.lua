dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
local x, y = self:transform()
local nearby_entities = EntityGetInRadiusWithTag( x, y, 128, "homing_target" ) or {};

local function angle_difference( target_angle, starting_angle )
    return math.atan2( math.sin( target_angle - starting_angle ), math.cos( target_angle - starting_angle ) );
end

if self.VelocityComponent ~= nil then
    local velocity = self.VelocityComponent.mVelocity
    local velocity_angle = math.atan2( velocity.y, velocity.x );
    for _, entity_id in pairs( nearby_entities ) do
        local ex, ey = EntityGetTransform(entity_id)
        local target_angle = math.atan2( ey - y, ex - x );
        local angle = math.abs(angle_difference( target_angle, velocity_angle ));
        local magnitude = math.sqrt( velocity.x * velocity.x + velocity.y * velocity.y );
        if angle < math.rad(92) and angle > math.rad(88) then
            velocity.x = math.cos(target_angle) * magnitude
            velocity.y = math.sin(target_angle) * magnitude
            self.VelocityComponent.mVelocity = velocity
        end
    end
end
