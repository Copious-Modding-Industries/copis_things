dofile_once("data/scripts/lib/utilities.lua")


local player = EntityGetWithTag( "player_unit" )[1]
local lerp_amount = 0.975
local bob_h = 6
local bob_w = 20
local bob_speed_y = 0.065
local bob_speed_x = 0.01421

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if pos_x == 0 and pos_y == 0 then
	-- get position from wand when starting
	pos_x, pos_y = EntityGetTransform(EntityGetParent(entity_id))
end

-- ghost continously lerps towards a target that floats around the parent
local target_x, target_y = EntityGetTransform(player)
if target_x == nil then return end
target_y = target_y - 10

local time = GameGetFrameNum()
local r = ProceduralRandomf(entity_id, 0, -1, 1)

-- randomize times and speeds slightly so that multiple ghosts don't fly identically
time = time + r * 10000
bob_speed_y = bob_speed_y + (r * bob_speed_y * 0.1)
bob_speed_x = bob_speed_x + (r * bob_speed_x * 0.1)
lerp_amount = lerp_amount - (r * lerp_amount * 0.01)

-- bob
target_y = target_y + math.sin(time * bob_speed_y) * bob_h
target_x = target_x + math.sin(time * bob_speed_x) * bob_w

local dist_x = pos_x - target_x


-- move towards target
pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, lerp_amount)
EntitySetTransform( entity_id, pos_x, pos_y)

edit_component( target_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = 0
    vars.on_collision_die = 0
	vars.penetrate_entities = 1
	vars.penetrate_world = 1
    vars.damage = 0
end)