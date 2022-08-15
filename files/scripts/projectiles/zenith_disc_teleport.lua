dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local entity_id = GetUpdatedEntityID()
local owner_id = 0
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" )
if ( comp ~= nil ) then
	owner_id = ComponentGetValue2( comp, "mWhoShot" )
end

local x, y, a, sx, sy = EntityGetTransform(entity_id)
local ox, oy = EntityGetTransform( owner_id )
SetRandomSeed(GetUpdatedComponentID() + 5, GameGetFrameNum())
x = x + (Random(0, 64) - 32)
SetRandomSeed(GetUpdatedEntityID(), GameGetFrameNum() -23)
y = y + (Random(0, 64) - 32)
EntitySetTransform(entity_id, x, y, a, sx, sy)