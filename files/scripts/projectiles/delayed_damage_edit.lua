local eid = GetUpdatedEntityID()
local pc = EntityGetFirstComponent(eid,"ProjectileComponent")
if pc then
    ComponentSetValue2(pc, "penetrate_entities", true)
    ComponentSetValue2(pc, "on_collision_die", true)
end