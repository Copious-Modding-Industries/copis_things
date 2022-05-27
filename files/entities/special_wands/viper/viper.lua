dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local entity_id = GetUpdatedEntityID()

local wand = EZWand(entity_id)

wand:AttachSpells("CURSE", "COPIS_THINGS_STAB", "COPIS_THINGS_SWORD_BLADE")
wand:SetFrozen(true, true)

local inherit_comp = EntityGetFirstComponent( entity_id, "InheritTransformComponent" )
EntityRemoveComponent(entity_id, inherit_comp)