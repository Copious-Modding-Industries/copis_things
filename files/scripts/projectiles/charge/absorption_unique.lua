local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast proj number]]

--_G["ABSRB_CHRG"][invid]


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