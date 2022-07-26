local entity = GetUpdatedEntityID();
local homing_comps = EntityGetComponent( entity, "ParticleEmitterComponent" ) or {};
for _,comp in pairs( homing_comps ) do
    EntityRemoveComponent( entity, comp );
end
