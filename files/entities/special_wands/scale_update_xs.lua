local entity_id = GetUpdatedEntityID()
local x, y,rad = EntityGetTransform(entity_id)
local sprite_comp = EntityGetComponentIncludingDisabled(entity_id ,  "SpriteComponent" , "item")[1]
if rad >= -math.pi/2 and rad <= math.pi/2 then    ComponentSetValue2(sprite_comp , "special_scale_y" , 0.7)
else
ComponentSetValue2(sprite_comp , "special_scale_y", -0.7)
end