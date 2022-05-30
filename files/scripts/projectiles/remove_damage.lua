dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
if ( comp ~= nil ) then
	ComponentSetValue2( comp, "damage", 0 )
end