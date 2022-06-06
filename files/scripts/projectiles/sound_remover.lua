dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")

local types = {
    "DAMAGE_MELEE",
    "DAMAGE_PROJECTILE",
    "DAMAGE_EXPLOSION",
    "DAMAGE_FIRE",
    "DAMAGE_ELECTRICITY",
    "DAMAGE_DRILL",
    "DAMAGE_SLICE",
    "DAMAGE_ICE"
}

if ( comp ~= nil ) then
	ComponentSetValue2( comp, "damage", 0 )
end