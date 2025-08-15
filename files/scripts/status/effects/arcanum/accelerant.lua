
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local min_x, max_x, min_y, max_y = -6, 6, -6, 6
local xp, yp, rr, sx = EntityGetTransform(root)
local hbc = EntityGetFirstComponent(root, "HitboxComponent")
if hbc then
	min_x = ComponentGetValue2(hbc, "aabb_min_x")-2
	max_x = ComponentGetValue2(hbc, "aabb_max_x")+2
	min_y = ComponentGetValue2(hbc, "aabb_min_y")-2
	max_y = ComponentGetValue2(hbc, "aabb_max_y")+2
end
local p = {
	x1 = GetValueNumber("gfx_x2", 0),
	x2 = GetValueNumber("gfx_x1", 0),
	y1 = GetValueNumber("gfx_y2", 0),
	y2 = GetValueNumber("gfx_y1", 0),
}

local spcs = EntityGetComponent(entity_id, "SpriteParticleEmitterComponent") --[[@cast spcs table]]
for i=1, #spcs do
	local spc = spcs[i]
	if (GameGetFrameNum()+(2*i)+(entity_id*12))%240 == 0 or ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted") == 1 then
		--SetRandomSeed(entity_id, root*8)
		--SetRandomSeed(GameGetFrameNum()+(entity_id*12), spc)
		SetValueNumber("gfx_x"..tostring(i), math.random(min_x, max_x))
		SetValueNumber("gfx_y"..tostring(i), math.random(min_y, max_y))
		SetValueNumber("gfx_r"..tostring(i), math.random(0, 2*math.pi))
	end
	local cxn, cyn, cxx, cyx = ComponentGetValue2(spc, "randomize_position")
	local r = GetValueNumber("gfx_r"..tostring(i), 0)*0.05+ComponentGetValue2(spc, "randomize_rotation")*0.95
	local x = GetValueNumber("gfx_x"..tostring(i), 0)*0.05+cxn*0.95
	local y = GetValueNumber("gfx_y"..tostring(i), 0)*0.05+cyn*0.95
	p["x"..tostring(i)]=x*sx
	p["y"..tostring(i)]=y
	--print(x, y)
	ComponentSetValue2(spc, "randomize_position", x, y, x, y)
	ComponentSetValue2(spc, "randomize_rotation", r, r)
end

local ray_x, ray_y = p.x2-p.x1, p.y2-p.y1
local dist = ((ray_x*ray_x)+(ray_y*ray_y))^0.5
local run, rise = ray_x/dist, ray_y/dist
for i=0, dist do
	GameCreateCosmeticParticle("spark_teal", xp+p.x1+run*i, yp+p.y1+rise*i, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
end