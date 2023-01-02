local entity_id = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform(entity_id)

local final_target
local final_x, final_y
local min_dist = math.huge
for _, target in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 128, "projectile")) do
    if not EntityHasTag(target, "projectile_player") then
        local tg_x, tg_y = EntityGetTransform(target)
        local dist = (tg_x - pos_x) ^ 2 + (tg_y - pos_y) ^ 2
        if dist < min_dist then
            min_dist = dist
            final_target = target
            final_x, final_y = tg_x, tg_y
        end
    end
end
if final_target then
    local angle = math.atan2((final_y - pos_y), (final_x - pos_x))

    local CS = (0.8) * math.cos(rot) + 0.2 * math.cos(angle)
    local SN = (0.8) * math.sin(rot) + 0.2 * math.sin(angle)

    rot = math.atan2(SN, CS)
else
    rot = rot + 0.025 % (math.pi * 2)
end

EntitySetTransform(entity_id, pos_x, pos_y, rot)