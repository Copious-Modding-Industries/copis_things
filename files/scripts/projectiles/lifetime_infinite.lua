dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")

local wand = EZWand.GetHeldWand()
if wand then
  local mana = wand.mana
  if (mana > 5) then
    wand.mana = mana - 5
  else
    EntityKill( entity_id )
  end
else
  EntityKill( entity_id )
end