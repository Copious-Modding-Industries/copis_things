dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local player = EntityGetWithTag( "player_unit" )[1]
local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")

EntitySetTransform( entity_id, mouse_x, mouse_y )