local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    ComponentSetValue2( projectile, "bounce_energy", 0 );
    ComponentSetValue2( projectile, "bounces_left", 100 );
    ComponentSetValue2( projectile, "bounce_always", true );
    ComponentSetValue2( projectile, "bounce_at_any_angle", true );
    ComponentSetValue2( projectile, "on_collision_die", true );
    ComponentSetValue2( projectile, "die_on_low_velocity", false );
end