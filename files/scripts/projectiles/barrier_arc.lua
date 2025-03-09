dofile_once("data/scripts/lib/utilities.lua")
local function shit(target, pos_x, pos_y)
	local function lerp(a, b, t) return a * (1 - t) + b * t end
	local tx, ty = EntityGetTransform(target)
	local distance = math.sqrt(math.pow(tx - pos_x, 2) + math.pow(ty - pos_y, 2))
	for dist = 1, distance, 16 do
		local px = lerp(pos_x, tx, (1 / distance) * dist)
		local py = lerp(pos_y, ty, (1 / distance) * dist)
		---@diagnostic disable-next-line: undefined-global  
		local wall_piece = shoot_projectile_from_projectile( entity_id, "data/entities/projectiles/deck/wall_piece.xml", px, py, 0, 0 )
		local projectile = EntityGetFirstComponentIncludingDisabled(wall_piece, "ProjectileComponent") --[[@cast projectile number]]
		ComponentSetValue2(projectile, "lifetime", 4)
	end
end

local entity_id = GetUpdatedEntityID()
local extract = dofile_once("mods/copis_things/files/scripts/lib/proj_data.lua")
local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast pcomp number]]
local cast_state = extract(pcomp, {1})
local pos_x, pos_y = EntityGetTransform(entity_id)
local player_projs = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "CASTSTATE_SHARED") or {}

for i=1, #player_projs do
	local target_pcomp = EntityGetFirstComponentIncludingDisabled(player_projs[i], "ProjectileComponent") --[[@cast target_pcomp number]]
	if cast_state == extract(target_pcomp, {1}) then
		shit(player_projs[i], pos_x, pos_y)
	end
end