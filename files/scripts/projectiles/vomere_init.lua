local entity = GetUpdatedEntityID();
local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity then
    ComponentSetValue2( velocity, "air_friction", math.random() * -2 - 1.5 );
end
local comp = EntityGetFirstComponent( entity, "VariableStorageComponent", "spawn_frame" );
if comp ~= nil then
    ComponentSetValue2( comp, "value_int", GameGetFrameNum());
end