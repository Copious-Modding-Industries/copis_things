dofile_once("data/scripts/lib/utilities.lua")
local entity = GetUpdatedEntityID();

local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity ~= nil then
    ComponentSetValue2( velocity, "terminal_velocity", 250 );
    ComponentSetValue2( velocity, "apply_terminal_velocity", true );
end