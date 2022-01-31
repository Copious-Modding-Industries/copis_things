dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

function get_random_between_range( target )
   --what REALLY affects max mana
	return 418
end

local entity_id = GetUpdatedEntityID()

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )
local inherit_comp = EntityGetFirstComponent( entity_id, "InheritTransformComponent" )

local gun = { }
gun.name = {"Hammer"}
gun.deck_capacity = 2
gun.actions_per_round = 2
gun.reload_time = 70
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = 0
gun.spread_degrees = 4
gun.speed_multiplier = 1
gun.mana_charge_speed = 130
gun.mana_max = {0,0}

local mana_max = get_random_between_range( gun.mana_max )
local deck_capacity = gun.deck_capacity

ComponentSetValue( ability_comp, "ui_name", "Hammer" )

ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", gun.reload_time )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", gun.fire_rate_wait )
ComponentSetValue( ability_comp, "mana_charge_speed", gun.mana_charge_speed)

ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", mana_max )
ComponentSetValue( ability_comp, "mana", mana_max )

AddGunActionPermanent( entity_id, "POWERDIGGER" )



EntityRemoveComponent(entity_id, inherit_comp)
