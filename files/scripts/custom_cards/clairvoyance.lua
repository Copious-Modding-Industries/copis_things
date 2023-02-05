local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local posx, posy = DEBUG_GetMouseWorld()
if not IsPlayer(root) then
    posx, posy = EntityGetTransform(root)
end
EntitySetTransform( entity_id, posx, posy )