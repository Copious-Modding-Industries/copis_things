local extract = dofile_once("mods/copis_things/files/scripts/lib/proj_data.lua")
local separator = GetUpdatedEntityID()
local pcomp = EntityGetFirstComponentIncludingDisabled(separator, "ProjectileComponent") --[[@cast pcomp number]]
local cast_state = extract(pcomp, {1})
local shooter = ComponentGetValue2(pcomp, "mWhoShot")

local sword_projs = {}
local player_projs = EntityGetWithTag("projectile_player") or {}
for i=1, #player_projs do
    if not EntityHasTag(player_projs[i], "SWORD_FORMATION") then goto skip end
	local target_pcomp = EntityGetFirstComponentIncludingDisabled(player_projs[i], "ProjectileComponent") --[[@cast target_pcomp number]]
	if extract(target_pcomp, {1}) == cast_state then
		sword_projs[#sword_projs+1] = player_projs[i]
	end
	::skip::
end

-- Add comps
for index = 1, #sword_projs do
    local target = sword_projs[index]
    EntityAddComponent(target, "VariableStorageComponent", {
        name = "formation_data",
        value_float = index,  -- "Position"
        value_int = shooter  -- "Leader"
    })
    EntityAddComponent(target, "LuaComponent", {
        script_source_file="mods/copis_things/files/scripts/projectiles/sword_transformer.lua",
        execute_every_n_frame=1
    })
end

EntityKill(separator)