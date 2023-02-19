local entity = GetUpdatedEntityID()
local comps = EntityGetComponent( entity, "ProjectileComponent" ) or {}
for i=1, #comps do
    comp = comps[i]
    ComponentSetValue2( comp, "on_death_explode", false )
    ComponentSetValue2( comp, "on_lifetime_out_explode", false )
    ComponentSetValue2( comp, "collide_with_entities", false )
    ComponentSetValue2( comp, "collide_with_world", false )
    ComponentSetValue2( comp, "lifetime", -1 )
end
EntityKill( entity )