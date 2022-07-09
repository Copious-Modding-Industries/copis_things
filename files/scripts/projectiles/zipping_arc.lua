local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- set away from closest surface
local found_normal,nx,ny,dist = GetSurfaceNormal( pos_x, pos_y, 20, 8 )
if found_normal then

    dist = dist*-1
    pos_x = pos_x + nx * dist
    pos_y = pos_y + ny * dist
    EntitySetTransform(entity_id, pos_x, pos_y)

end