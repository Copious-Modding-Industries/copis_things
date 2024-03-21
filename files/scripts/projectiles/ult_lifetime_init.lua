local entity_id = GetUpdatedEntityID()
local ltc = EntityGetComponentIncludingDisabled(entity_id, "LifetimeComponent") or {}
for i=1, #ltc do
	EntityRemoveComponent(entity_id, ltc[i])
end
local pc = EntityGetComponentIncludingDisabled(entity_id, "ProjectileComponent") or {}
for i=1, #pc do
	ComponentSetValue2(pc[i], "lifetime", -1)
end