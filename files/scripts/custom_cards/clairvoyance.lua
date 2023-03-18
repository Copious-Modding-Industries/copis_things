local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local posx, posy = 0, 0
local ctrls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
if ctrls ~= nil then
    posx, posy = ComponentGetValueVector2(ctrls, "mMousePosition")
else
    posx, posy = EntityGetTransform(root)
end
EntitySetTransform( entity_id, posx, posy )