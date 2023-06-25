local entity_id = GetUpdatedEntityID()
local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" )
    local ctrls = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
    if ctrls and shooter then
        local mouse_x, mouse_y = ComponentGetValue2(ctrls, "mMousePosition")
        EntitySetTransform( entity_id, mouse_x, mouse_y )
    end
end
