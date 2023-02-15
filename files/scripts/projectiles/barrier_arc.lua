dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()

if EntityGetName(entity_id) ~= "separator" then
    local caststate = nil
    do -- Get cast state
        local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)\n")
        caststate = (string.sub(desc, i, j))
    end

    local function lerp(a, b, t) return a * (1 - t) + b * t end
    local pos_x, pos_y = EntityGetTransform(entity_id)

    local player_projectiles = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "projectile_player") or {}
    for index = 1, #player_projectiles do
        local target = player_projectiles[index]
        if EntityHasTag(target, "BARRIER_ARC") then
            local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
            local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
            local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)\n")
            if (i or j) ~= nil then
                local target_caststate = (string.sub(desc, i, j))
                if target_caststate == caststate then
                    local tx, ty = EntityGetTransform(target)
                    local distance = math.sqrt(math.pow(tx - pos_x, 2) + math.pow(ty - pos_y, 2))
                    for dist = 1, distance, 12 do
                        local px = lerp(pos_x, tx, (1 / distance) * dist)
                        local py = lerp(pos_y, ty, (1 / distance) * dist)
                        local wall_piece = shoot_projectile_from_projectile(
                            entity_id,
                            "data/entities/projectiles/deck/wall_piece.xml",
                            px, py,
                            0, 0
                        )
                        local projectile = EntityGetFirstComponentIncludingDisabled(wall_piece, "ProjectileComponent")
                        if projectile ~= nil then
                            ComponentSetValue2(projectile, "lifetime", 2);
                            EntityRemoveTag(projectile, "projectile_player") -- lagproofing
                        end
                    end
                end
            end
        end
    end
end