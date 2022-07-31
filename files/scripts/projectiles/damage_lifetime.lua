dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
if ( comp ~= nil ) then
	local damage = ComponentGetValue2( comp, "damage" )
	damage = damage + (0.2/30)
	ComponentSetValue2( comp, "damage", damage )
end
--0.0666666667