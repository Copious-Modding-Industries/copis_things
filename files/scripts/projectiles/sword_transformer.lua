local projectile = GetUpdatedEntityID()
local vsc = EntityGetFirstComponentIncludingDisabled(projectile, "VariableStorageComponent", "SWORD_DATA")
local index = ComponentGetValue2(vsc, "value_float")
local leader = ComponentGetValue2(vsc, "value_int")

if EntityGetIsAlive(leader) then

    local dist_init = 4
    local inventory = EntityGetFirstComponent(leader, "Inventory2Component")
    local active_wand
    if inventory then
        active_wand = ComponentGetValue2(inventory, "mActiveItem")
        if EntityHasTag(active_wand, "wand") then
            local _, _, rot = EntityGetTransform(active_wand)
            local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos")
            if HotspotComponent then
                local ox, oy = ComponentGetValueVector2(HotspotComponent, "offset")
                dist_init = ox
            end
        end
    end

    local controls = EntityGetFirstComponent( leader ,"ControlsComponent" );
    if controls then

        -- Data
        local ax, ay = ComponentGetValue2( controls, "mAimingVectorNormalized" )
        local aim_angle = math.atan2( ay, ax )

        -- Transform
        local distance = (12 * index) + dist_init
        local wx, wy = EntityGetTransform( active_wand )
        EntityApplyTransform(
            projectile,
            wx + math.cos( aim_angle ) * distance,
            wy + math.sin( aim_angle ) * distance
        )

        -- Velocity
        local velocity = EntityGetFirstComponentIncludingDisabled( projectile, "VelocityComponent" );
        if velocity ~= nil then
            local vx, vy = ComponentGetValue2( velocity, "mVelocity" )
            local magnitude =  math.max( 20, math.sqrt( vx * vx + vy * vy ) );
            ComponentSetValue2(
                velocity,
                "mVelocity",
                math.cos( aim_angle ) * magnitude,
                math.sin( aim_angle ) * magnitude
            )
        end
    end
end