local entity_id = GetUpdatedEntityID()
local self_proj = EntityGetFirstComponent(EntityGetRootEntity(entity_id), "ProjectileComponent") --[[@cast self_proj number]]
local triggers = EntityGetWithTag("trigger") or {}
for i=1, #triggers do
	local root = EntityGetRootEntity(triggers[i])
	if root == entity_id then goto skip end
	local proj = EntityGetFirstComponent(root, "ProjectileComponent") --[[@cast proj number]]
	if ComponentObjectGetValue2(proj, "config", "action_type") == ComponentObjectGetValue2(self_proj, "config", "action_type") then
		EntityKill(triggers[i])
		EntityKill(root)
		break
	end
	::skip::
end