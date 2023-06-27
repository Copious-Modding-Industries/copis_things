local AltFireHandler = dofile_once("mods/copis_things/files/scripts/custom_cards/alt_fire_handler.lua") ---@module 'alt_fire_handler'
local entity_id = GetUpdatedEntityID()
AltFireHandler(
    entity_id,
    "mods/copis_things/files/entities/projectiles/grappling_hook.xml",
    30,         -- Cooldown frames
    500, 750,   -- Speed min and max
    12,         -- Mana cost
    false
)