dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "LightComponent")

if ( comp ~= nil ) then
	EntityRemoveComponent( entity_id, comp )
end