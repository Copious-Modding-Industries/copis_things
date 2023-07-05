local AltFireHandler = dofile_once("mods/copis_things/files/scripts/custom_cards/alt_fire_handler_auto.lua") ---@module 'alt_fire_handler'
local entity_id = GetUpdatedEntityID()
AltFireHandler(
    entity_id,
    "data/entities/projectiles/deck/flamethrower.xml",
    12,         -- Cooldown frames
    160, 170,   -- Speed min and max
    20          -- Mana cost
)