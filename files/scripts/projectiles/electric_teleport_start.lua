local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local vals = {start_x = x, start_y = y,}
local vscs = EntityGetComponent( entity_id, "VariableStorageComponent" ) or {}
for i=1, #vscs do
	local name = ComponentGetValue( vscs[i], "name" )
	if vals[name] then
		ComponentSetValue2( vscs[i], "value_string", tostring(vals[name]))
	end
end