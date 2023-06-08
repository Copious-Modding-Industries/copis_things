dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local targets = EntityGetInRadiusWithTag(pos_x,pos_y, 256,"homing_target")

local projectile_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
local who_shot = nil
if(projectile_comp)then
	who_shot = ComponentGetValue2( projectile_comp, "mWhoShot" )
end

local target_id = nil
local closest_distance = 257
for i, v in ipairs(targets)do
    if(v == who_shot)then goto continue end
    local target_x, target_y = EntityGetFirstHitboxCenter( v )
    local distance = math.sqrt( (target_x-pos_x)^2 + (target_y-pos_y)^2 )
    if (distance < closest_distance) then
        target_id = v
        closest_distance = distance
    end
    ::continue::
end

if target_id ~= nil then
    local target_x, target_y = EntityGetFirstHitboxCenter( target_id )
    local distance = math.sqrt( (target_x-pos_x)^2 + (target_y-pos_y)^2 )
    if (distance <= 256) then
        EntitySetTransform( entity_id, target_x, target_y )
    end
end