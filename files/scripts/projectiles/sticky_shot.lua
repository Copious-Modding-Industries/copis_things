local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- set to closest surface
local found_normal,nx,ny,dist = GetSurfaceNormal( pos_x, pos_y, 1, 8 )
if found_normal then

    pos_x = pos_x + nx
    pos_y = pos_y + ny
    EntitySetTransform(entity_id, pos_x, pos_y)

end

