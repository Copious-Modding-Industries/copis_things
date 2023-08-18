local entity_id = GetUpdatedEntityID()
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #spcs do
	local sprite = ComponentGetValue2(spcs[i], "image_file")
	if sprite == "data/ui_gfx/inventory/item_bg_other.png" then
		ComponentSetValue2(spcs[i], "image_file", "mods/copis_things/files/ui_gfx/gun_actions/extra_gfx/eviscerator_bg.png")
		break
	end
end