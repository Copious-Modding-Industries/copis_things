local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
local projcomp = EntityGetFirstComponent(parent, "ProjectileComponent") --[[@cast projcomp number]]
local shooter = ComponentGetValue2(projcomp, "mWhoShot")
if EntityGetIsAlive(shooter) then
    --local velocity  = EntityGetFirstComponent(parent, "VelocityComponent") --[[@cast velocity number]]
    --local vx, vy = ComponentGetValue2( velocity, "mVelocity")
    --local vel = (vx*vx+vy*vy)^0.5
    local spec = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")  --[[@cast spec number]]
    local px, py = EntityGetTransform(parent)
    local sx, sy = (function ()
        local x, y = EntityGetTransform(shooter)
        local inventory = EntityGetFirstComponent(shooter, "Inventory2Component")
        if inventory then
            local active_wand = ComponentGetValue2(inventory, "mActiveItem")
            if EntityHasTag(active_wand, "wand") then
                local _, _, rot = EntityGetTransform(active_wand)
                local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos") --[[@cast HotspotComponent number]]
                local ox, oy = ComponentGetValueVector2(HotspotComponent, "offset")
                local cosine = math.cos(rot)
                local sine   = math.sin(rot)
                local tip_x = cosine * ox - sine   * oy
                local tip_y = sine   * ox + cosine * oy
                x, y = x + tip_x, y + tip_y - 4
            end
        end
        return x, y
    end)()
    local angle = math.atan2(sy-py, sx-px)
    local scale = (((sx-px)^2+(sy-py)^2)^0.5)
    ComponentSetValue2(spec, "count_min", scale/8)
    ComponentSetValue2(spec, "count_max", scale/8)
    ComponentSetValue2(spec, "randomize_position", 0, -0.5, scale, 0.5)
    EntitySetTransform(entity_id, px, py)
    EntitySetTransform(parent, px, py, angle)
else
    EntityKill(entity_id)
end