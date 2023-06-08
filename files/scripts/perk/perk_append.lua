---@diagnostic disable: lowercase-global

-- Monkey Patching
perk_pickup = dofile_once("mods/copis_things/files/scripts/perk/functions/perk_pickup.lua").perk_pickup ---@type function
