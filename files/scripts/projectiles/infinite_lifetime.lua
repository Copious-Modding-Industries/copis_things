dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local wand = EZWand.GetHeldWand()
local mana = wand.mana
local manaMax = wand.manaMax
if (mana < 5) then
  EntityKill( entity_id )
else
  wand.mana = mana - 5
end