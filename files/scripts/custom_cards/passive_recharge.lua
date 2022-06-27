dofile("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local wand = EZWand.GetHeldWand()
if (wand.currentRechargeTime > 0) then
    wand.currentRechargeTime = wand.currentRechargeTime - 1
end
