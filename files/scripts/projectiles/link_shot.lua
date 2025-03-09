local entity_id = GetUpdatedEntityID()
local extract = dofile_once("mods/copis_things/files/scripts/lib/proj_data.lua")
if EntityGetName(entity_id) ~= "separator" then
	local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast pcomp number]]
	local cast_state = extract(pcomp, {1})

	local player_projs = EntityGetWithTag("projectile_player") or {}
	for i=1, #player_projs do
		local target_pcomp = EntityGetFirstComponentIncludingDisabled(player_projs[i], "ProjectileComponent") --[[@cast target_pcomp number]]
        if extract(target_pcomp, {1}) == cast_state then
            EntityKill(player_projs[i])
        end
    end
end