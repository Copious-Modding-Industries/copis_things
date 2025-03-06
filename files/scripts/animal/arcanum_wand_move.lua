dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if pos_x == 0 and pos_y == 0 then
	-- get position from wand when starting
	pos_x, pos_y = EntityGetTransform(EntityGetParent(entity_id))
end

-- ghost continously lerps towards a target that floats around the parent
local target_x, target_y = EntityGetTransform(EntityGetParent(entity_id))
if target_x == nil then return end
target_y = target_y - 10

local time = GameGetFrameNum()
local r = ProceduralRandomf(entity_id, 0, -1, 1)

-- randomize times and speeds slightly so that multiple ghosts don't fly identically
time = time + r * 10000

-- bob
target_y = target_y + math.sin(time * (0.06500 + (r * 0.06500 * 0.10))) * 6
target_x = target_x + math.sin(time * (0.01421 + (r * 0.01421 * 0.10))) * 20

-- move towards target
pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, (0.97500 - (r * 0.97500 * 0.01)))
EntitySetTransform( entity_id, pos_x, pos_y, 0, 1, 1)
