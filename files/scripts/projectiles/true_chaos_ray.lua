dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
RelatedProjectiles = RelatedProjectiles or {}
if #RelatedProjectiles == 0 then
    for i = 1, #actions do
        local action = actions[i]
        if action.related_projectiles ~= nil then
            RelatedProjectiles[#RelatedProjectiles + 1] = action.related_projectiles
        end
    end
end
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local angle        = math.rad(math.random(0, 359))
local length       = 600
local vel_x        = math.cos(angle) * length
local vel_y        = 0 - math.sin(angle) * length
local paths        = RelatedProjectiles[math.random(1, #RelatedProjectiles)]
for i = 1, #paths do
    local eid = shoot_projectile_from_projectile(entity_id, paths[i], pos_x, pos_y, vel_x, vel_y)
    EntityAddTag(eid, "projectile_cloned")
end
