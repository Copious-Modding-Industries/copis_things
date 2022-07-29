dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local target_id = EntityGetClosestWithTag(pos_x,pos_y,"homing_target")

if target_id ~= nil then
    local target_x, target_y = EntityGetFirstHitboxCenter( target_id )
    local distance = math.sqrt( (target_x-pos_x)^2 + (target_y-pos_y)^2 )
    if (distance <= 256) then
        EntitySetTransform( entity_id, target_x, target_y )
    end
end