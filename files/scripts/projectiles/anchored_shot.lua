dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
local x, y

local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( variablestorages ~= nil ) then
	for j,storage_id in ipairs(variablestorages) do
		local var_name = ComponentGetValue( storage_id, "name" )
		if ( var_name == "anchor_x" ) then
            x = ComponentGetValue2( storage_id, "value_float")
        elseif ( var_name == "anchor_y" ) then
            y = ComponentGetValue2( storage_id, "value_float")
		end
	end
end

EntitySetTransform(entity_id, x, y)
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
 	--ComponentSetValueVector2( comp, "mVelocity", 0, 0)
end)