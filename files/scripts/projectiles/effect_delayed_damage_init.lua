-- Get entity IDs
local entity_id	= GetUpdatedEntityID()
local victim_id	= EntityGetRootEntity(entity_id)
local victim_x, victim_y, victim_r, victim_sx, victim_sy = EntityGetTransform(victim_id)
local proj_id = (function ()
    local projectiles = EntityGetInRadiusWithTag(victim_x, victim_y, 32, "projectile_player") or {}
    local closest = { id = nil, dist = math.huge }
    for i=1, #projectiles do
        local target = projectiles[i]
        -- Skip over non-shooter shots
		local projc = EntityGetFirstComponent(target, "ProjectileComponent") --[[@cast projc number]]
		local varsc = EntityGetFirstComponent(entity_id, "VariableStorageComponent") --[[@cast varsc number]]
        if ComponentGetValue2(projc, "mWhoShot") ~= ComponentGetValue2(varsc, "value_int") then goto continue end
        -- Compare to closest
        local target_x, target_y = EntityGetTransform(target)
        local t_dist = (target_x-victim_x)^2+(target_y-victim_y)^2
        if closest.dist > t_dist then
            closest.dist = t_dist
            closest.id = target
        end
        ::continue::
    end
    return closest.id
end)()
if proj_id then
	local proj_x, proj_y = EntityGetTransform(proj_id)
	local spc = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent") --[[@cast spc number]]
	ComponentSetValue2(spc, "offset_x", proj_x)
	ComponentSetValue2(spc, "offset_y", proj_y)
end


--[[
if proj_id then

	-- MATH JUMPSCARE!! OOO SO SCARY
	local axe_x, axe_y = EntityGetTransform(proj_id)
	local offset_x = (victim_x-axe_x)/victim_sx
	local offset_y = (victim_y-axe_y)/victim_sy
	local cosine = math.cos(-victim_r)
	local sine   = math.sin(-victim_r)
	local offset_rx = cosine * offset_x + sine   * offset_y
	local offset_ry = sine   * offset_x - cosine * offset_y
end
math.randomseed(victim_id+entity_id^256, GameGetFrameNum())

local pos_x, pos_y = 0, 0
local hitbox = EntityGetFirstComponentIncludingDisabled( victim_id, "HitboxComponent" );
print(tostring(hitbox))
if hitbox ~= nil then
	print("AYE!!!!")
	local min_x = ComponentGetValue2( hitbox, "aabb_min_x" )
	local min_y = ComponentGetValue2( hitbox, "aabb_min_y" )
	pos_x = min_x + math.random() * ComponentGetValue2( hitbox, "aabb_max_x" ) - min_x
	pos_y = min_y + math.random() * ComponentGetValue2( hitbox, "aabb_max_y" ) - min_y
end
]]