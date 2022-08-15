dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()

local function ease_angle( angle, target_angle, easing )
    local dir = (angle - target_angle) / (math.pi*2);
    dir = dir - math.floor(dir + 0.5);
    dir = dir * (math.pi*2);
    return angle - dir * easing;
end

if self.VelocityComponent ~= nil then
    local velocity = self.VelocityComponent.mVelocity
    local magnitude = math.max( math.sqrt( velocity.x * velocity.x + velocity.y * velocity.y ), 50 );
    local angle = math.atan2( velocity.y, velocity.x );
    local new_angle = ease_angle( angle, self.var_float.copis_things_persistent_shot_angle, 0.15 );
    velocity.x = math.cos( new_angle ) * magnitude
    velocity.y = math.sin( new_angle ) * magnitude
    self.VelocityComponent.mVelocity = velocity
end