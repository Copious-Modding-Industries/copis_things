local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    ComponentSetValue2( projectile, "bounce_always", true );
    ComponentSetValue2( projectile, "bounce_at_any_angle", true );
end