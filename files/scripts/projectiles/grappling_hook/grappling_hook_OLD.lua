-- Get shooter entity
local entity_id = GetUpdatedEntityID()
local target = nil
local vscs = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
for i = 1, #vscs do
	if ComponentGetValue2(vscs[i], "name") == "target_ent" then
		target = ComponentGetValue2(vscs[i], "value_int")
	end
end
if not target or not EntityGetIsAlive(target) then EntityKill(entity_id) print("KILLING MYSELF!!!") end

-- Particle logic
local vtarget_x, vtarget_y, target_x, target_y = dofile_once("mods/copis_things/files/scripts/projectiles/wand_tip.lua")(target)
local pecs = EntityGetComponent(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
for i = 1, #pecs do
	if target_x and target_y then
		ComponentSetValue2(pecs[i], "mExPosition", vtarget_x, vtarget_y)
	end
end

-- Hooking logic
local pos_x, pos_y, angle = EntityGetTransform(entity_id)
local name = EntityGetName(entity_id)
local pull = false

if name == "grappling_hook_find" then
	-- Find valid victims
	local victims = EntityGetInRadiusWithTag(pos_x, pos_y, 8, "hittable") or {}
	for i=1, #victims do
		if victims[i] == target then goto cont end
		EntitySetName(entity_id, "grappling_hook_" .. tostring(victims[i]))
		goto found
		::cont::
	end
	if GetSurfaceNormal(pos_x, pos_y, 2, 8) then
		EntitySetName(entity_id, "grappling_hook_ground")
		name = "grappling_hook_ground"
	end
elseif name:sub(16,16)~="g" then
	-- Hooked onto ent
	local ent = tonumber(name:sub(16,-1)) or -1
	if not EntityGetIsAlive(ent) then EntityKill(entity_id) print("NO FRIENDS!!!!") end
	pos_x, pos_y = EntityGetTransform(ent)
	EntitySetTransform(entity_id, pos_x, pos_y)
	pull=true
	goto found
end

if name == "grappling_hook_ground" then
	local found_normal, nx, ny, dist = GetSurfaceNormal(pos_x, pos_y, 2, 8)
	local angle_new = math.atan2(pos_y - target_y, pos_x - target_x);
	if found_normal then
		angle = (angle + angle_new) / 2
		EntitySetTransform(entity_id, pos_x + nx * dist, pos_y + ny * dist, angle)
	end
	pull=true
end
::found::


if pull then
	-- Attractor logic
	local vcomp = EntityGetFirstComponent(target, "VelocityComponent")
	local cdc = EntityGetFirstComponent(target, "CharacterDataComponent")
	if cdc then
		local old_vx, old_vy = ComponentGetValueVector2(cdc, "mVelocity")
		local vx = (pos_x - target_x)
		local vy = (pos_y - target_y)
		local vel = (vx ^ 2 + vy ^ 2) ^ .5
		local vel_cap = math.min(150, vel)     -- Please provide feedback on how fast this feels! 250 is a little too strong, but 50 is too gentle imo
		vx = (vx / vel) * vel_cap
		vy = (vy / vel) * vel_cap
		if ((pos_x - target_x) ^ 2 + (pos_y - target_y) ^ 2) < 750 then
			-- Hook lifetime behaviour
			EntityAddComponent2(entity_id, "LifetimeComponent", { lifetime = 1 })
			-- Last fling :troll:
			vx = vx * 12
			vy = vy * 12
		end
		ComponentSetValue2(cdc, "mVelocity", old_vx + vx, old_vy + vy)
	elseif vcomp then
		local vel_x, vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
		ComponentSetValue2(vcomp, "mVelocity", vel_x + (pos_x - target_x), vel_y + (pos_y - target_y))
	end
end

