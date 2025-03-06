local entity_id = GetUpdatedEntityID()
local spc = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent") --[[@cast spc number]]
local root = EntityGetRootEntity(entity_id)
if (GameGetFrameNum()+(entity_id*12))%60 == 0 or ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted") == 1 then
	local a, b, c, d = -6, 6, -6, 6
	local hbc = EntityGetFirstComponent(root, "HitboxComponent")
	if hbc then
		a = ComponentGetValue2(hbc, "aabb_min_x")-2
		b = ComponentGetValue2(hbc, "aabb_max_x")+2
		c = ComponentGetValue2(hbc, "aabb_min_y")-2
		d = ComponentGetValue2(hbc, "aabb_max_y")+2
	end
	--SetRandomSeed(entity_id, root*8)
	--SetRandomSeed(GameGetFrameNum()+(entity_id*12), spc)
	SetValueNumber("gfx_x", math.random(a, b))
	SetValueNumber("gfx_y", math.random(c, d))
	SetValueNumber("gfx_r", math.random(0, 2*math.pi))
end
local cxn, cxx, cyn, cyx = ComponentGetValue2(spc, "randomize_position")
local r = GetValueNumber("gfx_r", 0)*0.05+ComponentGetValue2(spc, "randomize_rotation")*0.95
local x = GetValueNumber("gfx_x", 0)*0.05+cxn*0.95
local y = GetValueNumber("gfx_y", 0)*0.05+cyn*0.95
--print(x, y)
ComponentSetValue2(spc, "randomize_position", x, y, x, y)
ComponentSetValue2(spc, "randomize_rotation", r, r)