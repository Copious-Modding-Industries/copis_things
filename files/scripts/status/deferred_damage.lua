dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local DAMAGE_MELEE = 0
local DAMAGE_PROJECTILE = 0
local DAMAGE_EXPLOSION = 0
local DAMAGE_ELECTRICITY
local DAMAGE_FIRE = 0
local DAMAGE_DRILL = 0
local DAMAGE_SLICE = 0
local DAMAGE_ICE = 0

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

EntityInflictDamage( entity_id(), DAMAGE_MELEE, "DAMAGE_MELEE", "Deferred damage", "BLOOD_SPRAY", 0, 0)