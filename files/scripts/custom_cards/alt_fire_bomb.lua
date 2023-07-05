local AltFireHandler = dofile_once("mods/copis_things/files/scripts/custom_cards/alt_fire_handler_limited.lua") ---@module 'alt_fire_handler'
local entity_id = GetUpdatedEntityID()
AltFireHandler(
    entity_id,
    "data/entities/projectiles/bomb.xml",
    30,         -- Cooldown frames
    60, 60,     -- Speed min and max
    100         -- Mana cost
)