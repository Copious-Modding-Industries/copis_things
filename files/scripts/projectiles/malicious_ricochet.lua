local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
if ComponentGetValue2(projcomp, "mLastFrameDamaged") == GameGetFrameNum() then
	local x, y = EntityGetTransform(entity_id)
	local targets = EntityGetInRadiusWithTag(x, y, 256, "homing_target") or {}
	for i=1, #targets do
		if targets[i]==EntityGetClosestWithTag(x, y, "homing_target") then table.remove(targets, i) break end
	end



	if #targets<1 then 
		EntitySetComponentsWithTagEnabled(entity_id, "grow", false)
	else
		EntitySetComponentsWithTagEnabled(entity_id, "grow", true)
	end
	local hcomps = EntityGetComponentIncludingDisabled(entity_id, "HomingComponent") or {}
	local target = targets[math.random(1, #targets)]
	local tx, ty = EntityGetTransform(target)
	GameCreateSpriteForXFrames( "data/particles/radar_enemy_strong.png", tx, ty, true, 0, 0, 32, true )
	for i=1, #hcomps do
		if ComponentGetValue2(hcomps[i], "target_tag")=="homing_target" then
			ComponentSetValue2(hcomps[i], "predefined_target", target)
		end
	end
	--[=[
	local angle = math.atan2( ty-y, tx-x )
	local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
	local vx, vy = ComponentGetValue2(velcomp, "mVelocity")
	local magnitude = 100*(vx*vx+vy*vy)^0.5
	ComponentSetValue2(velcomp, "mVelocity", math.cos( angle )*magnitude, math.sin( angle )*magnitude)]=]
end
