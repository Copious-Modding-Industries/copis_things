local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local shooter = ComponentGetValue2(projcomp, "mWhoShot")
local x, y, rot = (function ()
    local x, y, rot = EntityGetTransform(shooter)
    local hitbox    = EntityGetFirstComponent(shooter, "HitboxComponent" )
    local controls  = EntityGetFirstComponent(shooter, "ControlsComponent" )
    if hitbox then
        x = x+ComponentGetValue2( hitbox,"aabb_min_x")+(ComponentGetValue2(hitbox,"aabb_max_x")-ComponentGetValue2( hitbox,"aabb_min_x"))*0.5
        y = y+ComponentGetValue2( hitbox,"aabb_min_y")+(ComponentGetValue2(hitbox,"aabb_max_y")-ComponentGetValue2( hitbox,"aabb_min_y"))*0.5
    end
    if controls then
        local aim_x, aim_y = ComponentGetValue2(controls, "mAimingVectorNormalized") --[[@cast aim_x number]] --[[@cast aim_y number]]
        rot = math.atan2( aim_y, aim_x )
    end
    return x, y, rot
end)()
EntitySetTransform(entity_id, x, y, rot)