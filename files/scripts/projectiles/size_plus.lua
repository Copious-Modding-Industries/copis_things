local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if proj then

end

local sprites = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #sprites do
    ComponentSetValue2(sprites[i], "has_special_scale", true)
    ComponentSetValue2(sprites[i], "special_scale_x", ComponentGetValue2(sprites[i], "special_scale_x") * 1.2)
    ComponentSetValue2(sprites[i], "special_scale_y", ComponentGetValue2(sprites[i], "special_scale_y") * 1.2)
end