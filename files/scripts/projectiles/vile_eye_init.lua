local entity_id = GetUpdatedEntityID()
local player_projs = EntityGetWithTag("projectile_player") or {}
for i=1, #player_projs do
	local proj = player_projs[i]
	if proj ~= entity_id and EntityGetName(proj) == "vile_eye" then EntityKill(proj) end
end