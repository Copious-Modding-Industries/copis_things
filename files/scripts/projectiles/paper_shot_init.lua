dofile_once("data/scripts/lib/utilities.lua")
local entity = GetUpdatedEntityID();

local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity ~= nil then
    local terminal_velocity = ComponentGetValue2( velocity, "terminal_velocity" );
    ComponentSetValue2( velocity, "terminal_velocity", math.min(250, terminal_velocity/2) );
    ComponentSetValue2( velocity, "apply_terminal_velocity", true );
end