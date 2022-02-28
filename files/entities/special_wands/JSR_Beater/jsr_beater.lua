dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()

local inherit_comp = EntityGetFirstComponent( entity_id, "InheritTransformComponent" )

AddGunActionPermanent( entity_id, "DAMAGE_FOREVER" )
AddGunActionPermanent( entity_id, "COPIS_THINGS_JSR_BLAST" )

EntityRemoveComponent(entity_id, inherit_comp)