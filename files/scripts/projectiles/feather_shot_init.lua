dofile_once("data/scripts/lib/utilities.lua")
local entity = GetUpdatedEntityID();

local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity ~= nil then
    local terminal_velocity = ComponentGetValue2(velocity, "terminal_velocity")
    ComponentSetValue2( velocity, "terminal_velocity", terminal_velocity * 0.18 );
    ComponentSetValue2( velocity, "apply_terminal_velocity", true );
end

local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    ComponentSetValue2( projectile, "die_on_low_velocity", false );
end