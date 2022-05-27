dofile("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local wand = EZWand.GetHeldWand()
local mana = wand.mana
local manaMax = wand.manaMax
if (mana < manaMax) then
    wand.mana = mana + 1
end