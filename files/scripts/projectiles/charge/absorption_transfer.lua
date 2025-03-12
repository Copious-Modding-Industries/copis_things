-- Detects projectiles in the area. Known to have tag projectile 
---@diagnostic disable-next-line: lowercase-global
function collision_trigger(colliding_entity_id)
	local entity_id = GetUpdatedEntityID()
	if colliding_entity_id == entity_id then return end -- Skip this spell
	local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast proj number]]
	local shooter = ComponentGetValue2(proj, "mWhoShot")
	local abs_proj = EntityGetFirstComponent(colliding_entity_id, "ProjectileComponent") --[[@cast abs_proj number]]
	local abs_shooter = ComponentGetValue2(abs_proj, "mWhoShot")
	-- If the charger is not the absorb proj shooter, or if friendly fire
	if abs_shooter~=shooter or ComponentGetValue2(abs_proj, "friendly_fire") then
		local invid = ComponentObjectGetValue2(proj, "config", "action_type")
		-- Add 0.5s charge, max of 600
		_G["ABSRB_CHRG"][invid] = math.max(600, (_G["ABSRB_CHRG"][invid] or 0)+30)
	end
end


-- The below code runs each frame



local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast proj number]]
local invid = ComponentObjectGetValue2(proj, "config", "action_type")
-- Charge amount corellated with this inventory ID.
local charge = _G["ABSRB_CHRG"][invid] or 0

-- if charge is maxed
if (charge)>=600 then
	
else
	_G["ABSRB_CHRG"][invid] = charge+1
end











-- This should be ordered by oldest to newest. The scripts also run in this order due to being created. Iterate backwards and kill duplicates.
local newest = {}
local triggers = EntityGetWithTag("trigger") or {}
for i=#triggers, 1, -1 do
	local root = EntityGetRootEntity(triggers[i])
	if (not EntityGetName(root)=="copicharge_absorption") then goto skip end -- Skip non-charge absorption spells
	local root_proj = EntityGetFirstComponent(root, "ProjectileComponent") or 0
	local root_invid = ComponentObjectGetValue2(root_proj, "config", "action_type")
	if not newest[root_invid] then
		newest[root_invid]=true -- Mark that we have the newest one of this invid
	else
		EntityKill(triggers[i]) -- Kill older ones
		EntityKill(root)
	end
	::skip::
end

-- Now we know we have only one of each.