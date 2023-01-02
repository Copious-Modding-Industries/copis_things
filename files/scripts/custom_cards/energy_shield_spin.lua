local entity_id = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
EntitySetTransform( entity_id, pos_x, pos_y, rot + 0.05 % (math.pi * 2) )