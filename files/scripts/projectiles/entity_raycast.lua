dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

--https://love2d.org/forums/viewtopic.php?p=70539#p70539 
local function boxSegmentIntersection(l,t,w,h, x1,y1,x2,y2)
    local dx, dy  = x2-x1, y2-y1

    local t0, t1  = 0, 1
    local p, q, r

    for side = 1,4 do
        if     side == 1 then p,q = -dx, x1 - l
        elseif side == 2 then p,q =  dx, l + w - x1
        elseif side == 3 then p,q = -dy, y1 - t
        else                  p,q =  dy, t + h - y1
        end

        if p == 0 then
        if q < 0 then return nil end  -- Segment is parallel and outside the bbox
        else
        r = q / p
        if p < 0 then
            if     r > t1 then return nil
            elseif r > t0 then t0 = r
            end
        else -- p > 0
            if     r < t0 then return nil
            elseif r < t1 then t1 = r
            end
        end
        end
    end

    local ix1, iy1, ix2, iy2 = x1 + t0 * dx, y1 + t0 * dy,
                                x1 + t1 * dx, y1 + t1 * dy

    if ix1 == ix2 and iy1 == iy2 then return ix1, iy1 end
    return ix1, iy1, ix2, iy2
end

local self = Entity.Current()
local range = 120
local vel_x
local vel_y

local projectile_x, projectile_y = self:transform()
--[[
if self.VelocityComponent then
    vel_x = self.VelocityComponent.mVelocity.x
    vel_y = self.VelocityComponent.mVelocity.y
end
]]

edit_component( GetUpdatedEntityID(), "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity" )
end)

local angle = math.atan2(vel_y, vel_x)
print(math.deg(angle))
local end_x = projectile_x + math.cos(angle) * 120
local end_y = projectile_y + math.sin(angle) * 120

local success,hit_x,hit_y = RaytracePlatforms( projectile_x, projectile_y, end_x, end_y )
if success then
	end_x = hit_x
	end_y = hit_y
end

--for each target within range
local targets = self.GetInRadius(projectile_x, projectile_y, range, "hittable")
for _, target in targets:ipairs() do
    local target_x, target_y = target:transform()
    -- for each hitbox
    if target.HitboxComponent then
        for _, hitbox in target.HitboxComponent:ipairs() do
            local min_x = hitbox.aabb_min_x
            local max_x = hitbox.aabb_max_x
            local min_y = hitbox.aabb_min_y
            local max_y = hitbox.aabb_max_y

            local width = max_x - min_x;
            local height = max_y - min_y;
            local aabb_x = target_x-- + (min_x + width * 0.5);
            local aabb_y = target_y-- + (min_y + height * 0.5);

            local hit_x1, hit_y1, hit_x2, hit_y2 = boxSegmentIntersection(aabb_x, aabb_y, width, height, projectile_x, projectile_y, end_x, end_y)

            if (hit_x1 ~= nil) and (hit_y1 ~= nil) then
                if get_magnitude(hit_x1,hit_y1) <= get_magnitude(end_x,end_y) then
                    end_x = hit_x1
                    end_y = hit_y1
                end
            end
            if (hit_x2 ~= nil) and (hit_y2 ~= nil) then
                if get_magnitude(hit_x2,hit_y2) <= get_magnitude(end_x,end_y) then
                    end_x = hit_x2
                    end_y = hit_y2
                end
            end
        end
    end
end

EntityLoad("data/entities/_debug/debug_marker.xml", end_x, end_y)