local entity_id = GetUpdatedEntityID()
--






dofile_once("data/scripts/lib/utilities.lua")

-- get shooter
local proj = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) --[[@cast proj number]]
local spec = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteParticleEmitterComponent" ) --[[@cast spec number]]
local who_shot = ComponentGetValue2( proj, "mWhoShot")


local valid = {}
local x, y = EntityGetTransform(entity_id)
local mortals = EntityGetInRadiusWithTag(x, y, 256, "mortal") or {}
for i=1, #mortals do
	local mortal = mortals[i]
	local tx, ty = EntityGetFirstHitboxCenter( mortal ) --[[@cast tx number]] --[[@cast ty number]]
	--GameCreateSpriteForXFrames( "data/particles/radar_wand_strong.png", tx, ty )
	if EntityGetComponent(mortal, "GenomeDataComponent") then
		if EntityGetHerdRelation(who_shot, mortal) < 70 and mortal ~= who_shot then
			if not RaytracePlatforms(x, y, tx, ty) then
				valid[#valid+1] = mortal
			end
		end
	end
end

local target = valid[math.random(1, #valid)]
local vel = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ) --[[@cast vel number]]
local vx, vy = ComponentGetValue2( vel, "mVelocity")
if target then
	local tx, ty = EntityGetTransform(target)
	vx, vy = tx-x, ty-y
	local speed = (vx*vx+vy*vy)^0.5
	vx, vy = (vx/speed)*12, (vy/speed)*12

	ComponentSetValue2( vel, "mVelocity", vx, vy)
end
local r = math.atan2( vy, vx )
ComponentSetValue2( spec, "randomize_rotation", r-0.01, r+0.01 )
ComponentSetValue2( spec, "is_emitting", true )
local sign = vx>0 and 1 or -1
ComponentSetValue2( spec, "angular_velocity", sign*-1 )
ComponentSetValue2( spec, "randomize_position", -1, sign*3, -1, sign*3 )
ComponentSetValue2( spec, "sprite_file", table.concat{"mods/copis_things/files/particles/flurry_", vx>0 and "R" or "L", ".png"})