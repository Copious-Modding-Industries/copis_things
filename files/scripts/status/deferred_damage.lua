dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local DAMAGE_MELEE = 0
local DAMAGE_PROJECTILE = 0
local DAMAGE_EXPLOSION = 0
local DAMAGE_FIRE = 0
local DAMAGE_DRILL = 0
local DAMAGE_SLICE = 0
local DAMAGE_ICE = 0

EntityInflictDamage( entity_id(), DAMAGE_MELEE, "DAMAGE_MELEE", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_PROJECTILE, "DAMAGE_PROJECTILE", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_EXPLOSION, "DAMAGE_EXPLOSION", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_FIRE, "DAMAGE_FIRE", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_ELECTRICITY, "DAMAGE_ELECTRICITY", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_DRILL, "DAMAGE_DRILL", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_SLICE, "DAMAGE_SLICE", "Deferred damage", "BLOOD_SPRAY", 0, 0)
EntityInflictDamage( entity_id(), DAMAGE_ICE, "DAMAGE_ICE", "Deferred damage", "BLOOD_SPRAY", 0, 0)