local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
if ComponentGetValue2(projcomp, "mLastFrameDamaged") == GameGetFrameNum() then
	local x, y = EntityGetTransform(entity_id)
	local targets = EntityGetInRadiusWithTag(x, y, 128, "homing_target") or {}
	local skip = {}
	local damaged = ComponentGetValue2(projcomp, "mDamagedEntities") or {}
	for k=1, #damaged do
		skip[damaged[k]]=true
	end
	for i=1, #targets do
		if targets[i]==EntityGetClosestWithTag(x, y, "homing_target") then table.remove(targets, i) end
		if skip[targets[i]] then table.remove(targets, i) end
	end

	if #targets<1 then
		EntitySetComponentsWithTagEnabled(entity_id, "grow", false)
	else
		EntitySetComponentsWithTagEnabled(entity_id, "grow", true)
		local hcomps = EntityGetComponentIncludingDisabled(entity_id, "HomingComponent") or {}
		local target = targets[math.random(1, #targets)]
		local tx, ty = EntityGetTransform(target)
		GameCreateSpriteForXFrames( "data/particles/radar_enemy_strong.png", tx, ty, true, 0, 0, 32, true )
		for i=1, #hcomps do
			ComponentSetValue2(hcomps[i], "predefined_target", target)
		end

		local angle = math.atan2( ty-y, tx-x )
		local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
		local vx, vy = ComponentGetValue2(velcomp, "mVelocity")
		local magnitude = 1.1*(vx*vx+vy*vy)^0.5
		ComponentSetValue2(velcomp, "mVelocity", math.cos( angle )*magnitude, math.sin( angle )*magnitude)--[=[]=]
	end


	local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
	ComponentSetValue2(projcomp, "damage", ComponentGetValue2(projcomp,"damage")*1.1)
	for i=1,#damage_types do
		ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp,"damage_by_type",damage_types[i])*1.1)
	end

	ComponentSetValue2(projcomp, "lifetime", ComponentGetValue2(projcomp, "lifetime")+10)
end
