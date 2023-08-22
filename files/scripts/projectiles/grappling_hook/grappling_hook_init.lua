local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
do -- Get shooter ent
	local vars = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
	for i = 1, #vars do
		if ComponentGetValue2(vars[i], "name") == "target_ent" then
			local ent_that_shot = ComponentGetValue2(projcomp, "mEntityThatShot")
			local target = (ent_that_shot ~= 0) and ent_that_shot or ComponentGetValue2(projcomp, "mWhoShot")
			ComponentSetValue2(vars[i], "value_int", target)
		end
	end
end
-- SWITCH TO STATE
local luacomps = EntityGetComponent(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/copis_things/files/scripts/projectiles/grappling_hook/grappling_hook_looking.lua" then
        ComponentSetValue2(luacomps[i], "execute_every_n_frame", 1)
		break
    end
end