local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( pos_x + pos_y, GameGetFrameNum() )

EntitySetTransform( entity_id, pos_x + Random(-32, 32), pos_y + Random(-32, 32),Random(0,6.28319))