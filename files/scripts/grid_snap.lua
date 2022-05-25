dofile_once( "data/scripts/lib/utilities.lua" )

function round(n, to)
    return math.floor(n/to + 0.5) * to
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

EntityLoad( "mods/copis_things/files/entities/buildings/cage_building.xml", round(x, 32), round(y, 32) )