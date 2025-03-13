local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
if ComponentGetValue2(projcomp, "mLastFrameDamaged") == GameGetFrameNum() then
	GamePrint("!!!")
	local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
	ComponentSetValue2( projcomp, "damage", ComponentGetValue2( projcomp, "damage" )/1.5 )
	for i=1, #damage_types do
		ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp, "damage_by_type", damage_types[i])/1.5)
	end
end