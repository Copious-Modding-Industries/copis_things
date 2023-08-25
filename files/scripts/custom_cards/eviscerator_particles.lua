local entity_id = GetUpdatedEntityID()
local specs = EntityGetComponent(entity_id, "SpriteParticleEmitterComponent") or {}
local now = GameGetFrameNum()
for i=1, #specs do
	local spec = specs[i]

	local sprite = ComponentGetValue2(spec, "sprite_file")
	local indx = tonumber(sprite:sub(-5,-5))
	local offset = 120*indx
	local angle = math.rad((now/4+offset)%360)

	local length = 17.5 + math.sin(now/12+indx)
	local px = math.cos( angle ) * length
	local py = -math.sin( angle ) * length/1.5

	ComponentSetValue2(spec, "render_back", py<=0)
	ComponentSetValue2(spec, "rotation", angle)
	ComponentSetValue2(spec, "randomize_position", px, py-10, px, py-10)

end