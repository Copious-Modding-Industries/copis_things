dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
local pos_x, pos_y, angle, scale_x, scale_y = self:transform()

local found_normal,nx,ny,dist = GetSurfaceNormal( pos_x, pos_y, 2, 8 )
if found_normal then
    pos_x = pos_x + nx
    pos_y = pos_y + ny
    angle = math.atan2( pos_y + ny, pos_x + nx );
    self:setTransform(pos_x, pos_y, angle, scale_x, scale_y)
end