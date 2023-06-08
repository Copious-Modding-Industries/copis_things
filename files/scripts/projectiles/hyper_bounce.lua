local eid = GetUpdatedEntityID()
local pc = EntityGetFirstComponent(eid,"ProjectileComponent")
if pc then
    ComponentSetValue2(pc, "bounce_energy", math.max( 1.10, ComponentGetValue2(pc, "bounce_energy") + 0.10 ))
    ComponentSetValue2(pc, "bounce_at_any_angle", true)
end