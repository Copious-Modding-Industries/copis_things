local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y + GameGetFrameNum() + 137 )
EntityLoad( "mods/copis_things/files/entities/buildings/breach_".. tostring(Random(1,2)) .."_building.xml", x, y)