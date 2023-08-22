local entity_id = GetUpdatedEntityID()
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
local victim, target
local victim_x, victim_y
for i=1,#vscs do
    local comp = vscs[i]
    local name = ComponentGetValue2(comp, "name")
    if name == "grappling_hook_victim" then
        victim = ComponentGetValue2(comp, "value_int")
        if EntityGetIsAlive(victim) then
            -- Move hook to victim
            local px, py, pa = EntityGetTransform(entity_id)
            victim_x, victim_y = EntityGetTransform(victim)
            EntitySetTransform(entity_id, victim_x, victim_y)
			local velocity  = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velocity number]]
			local vel_x = math.cos(pa)
			local vel_y = math.sin(pa)
			ComponentSetValue2(velocity, "mVelocity", vel_y, vel_x)
        else
            -- Dislodge
            EntityRemoveComponent(entity_id, GetUpdatedComponentID())
        end
	elseif name == "target_ent" then
		target = ComponentGetValue2(comp, "value_int")
    end
end
-- Only pass here if both target and victims exist and are alive
if not EntityGetIsAlive(target) then EntityKill(entity_id) end

-- Particle logic
local vtarget_x, vtarget_y, target_x, target_y = dofile_once("mods/copis_things/files/scripts/projectiles/wand_tip.lua")(target)
local pecs = EntityGetComponent(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
for i = 1, #pecs do
	if target_x and target_y then
		ComponentSetValue2(pecs[i], "mExPosition", vtarget_x, vtarget_y)
	end
end

-- Attractor logic
local vcomp = EntityGetFirstComponent(target, "VelocityComponent")
local cdc = EntityGetFirstComponent(target, "CharacterDataComponent")
if cdc then
	local old_vx, old_vy = ComponentGetValueVector2(cdc, "mVelocity")
	local vx = (victim_x - target_x)
	local vy = (victim_y - target_y)
	local vel = (vx ^ 2 + vy ^ 2) ^ .5
	local vel_cap = math.min(250, vel)	-- Bonus speed towards enemies
	vx = (vx / vel) * vel_cap
	vy = (vy / vel) * vel_cap
	if ((victim_x - target_x) ^ 2 + (victim_y - target_y) ^ 2) < 750 then
		-- Hook lifetime behaviour
		EntityAddComponent2(entity_id, "LifetimeComponent", { lifetime = 1 })
		-- Last fling :troll:
		vx = vx * 12
		vy = vy * 12
	end
	ComponentSetValue2(cdc, "mVelocity", old_vx + vx, old_vy + vy)
elseif vcomp then
	local vel_x, vel_y = ComponentGetValueVector2(vcomp, "mVelocity")
	ComponentSetValue2(vcomp, "mVelocity", vel_x + (victim_x - target_x), vel_y + (victim_y - target_y))
end