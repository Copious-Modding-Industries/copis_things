dofile_once( "data/scripts/lib/utilities.lua" )

function round(n, to)
    return math.floor(n/to + 0.5) * to
end
local entity_id    = GetUpdatedEntityID()
local player = EntityGetWithTag( "player_unit" )[1]
local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")

EntitySetTransform( entity_id, round(mouse_x,16), round(mouse_y,16) )