local entity_id = GetUpdatedEntityID()
local scale = 0.7
local x, y,rad = EntityGetTransform(entity_id)
local sprite_comp = EntityGetComponentIncludingDisabled(entity_id ,  "SpriteComponent" , "item")[1]
if rad >= -math.pi/2 and rad <= math.pi/2 then    ComponentSetValue2(sprite_comp , "special_scale_y" , scale)
else
ComponentSetValue2(sprite_comp , "special_scale_y", -scale)
end