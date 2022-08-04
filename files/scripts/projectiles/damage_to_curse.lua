dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
GamePrint("AAA")
if ( comp ~= nil ) then
	local damage = ComponentGetValue2( comp, "damage" )
	local damage_converted

	damage = damage * 0.2
	damage_converted = damage * 0.8

	ComponentSetValue2( comp, "damage", damage )
	ComponentObjectSetValue2( comp, "damage_by_type", "curse", damage_converted)
end