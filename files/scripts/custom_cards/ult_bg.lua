local entity_id = GetUpdatedEntityID()
local spc = EntityGetFirstComponent(entity_id, "SpriteComponent", "item_bg")
ComponentSetValue2(spc, "image_file", "mods/copis_things/files/ui_gfx/gun_actions/extra_gfx/ult_bg.png")
ComponentSetValue2(spc, "alpha", 1)