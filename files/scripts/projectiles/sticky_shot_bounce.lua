local entity = GetUpdatedEntityID();
local comp = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if comp ~= nil then
    --local bounce_energy = ComponentGetValue2( projectile, "bounce_energy" );
    ComponentSetValue2( comp, "gravity_y", 0 );
end