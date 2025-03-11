local entity_id = GetUpdatedEntityID()
local specs= EntityGetComponent(entity_id, "SpriteParticleEmitterComponent") or {}
local _, _, r = EntityGetTransform(entity_id)
for i=1, #specs do
	ComponentSetValue2( specs[i], "randomize_rotation", r, r)
	ComponentSetValue2( specs[i], "is_emitting", true )
end