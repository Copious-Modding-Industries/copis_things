dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" );
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0;
    local ctrls = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
    if ctrls ~= nil then
        local mouse_x, mouse_y = ComponentGetValue2(ctrls, "mMousePosition")
        EntitySetTransform( entity_id, mouse_x, mouse_y )
    end
end
