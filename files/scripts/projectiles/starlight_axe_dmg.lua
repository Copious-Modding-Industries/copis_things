local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
if ComponentGetValue2(projcomp, "mLastFrameDamaged") == GameGetFrameNum() then
	local hits = GetValueInteger("hits", 0)
	if hits >=8 then EntityKill(entity_id) end
	SetValueInteger("hits", hits+1)
	local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
	ComponentSetValue2( projcomp, "damage", ComponentGetValue2( projcomp, "damage" )*0.75 )
	for i=1, #damage_types do
		ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp, "damage_by_type", damage_types[i])*0.75)
	end
end