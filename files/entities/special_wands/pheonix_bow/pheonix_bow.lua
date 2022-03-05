dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()

local inherit_comp = EntityGetFirstComponent( entity_id, "InheritTransformComponent" )

AddGunActionPermanent( entity_id, "speed" )
AddGunActionPermanent( entity_id, "copis_things_levity_shot" )
AddGunActionPermanent( entity_id, "arrow" )

EntityRemoveComponent(entity_id, inherit_comp)