dofile_once("data/scripts/lib/utilities.lua")                                                       -- TODO: purge this
local entity_id = GetUpdatedEntityID()
if EntityGetName(entity_id) ~= "separator" then                                                     -- Avoid indexer projectiles running
    if EntityHasTag(entity_id, "CASTSTATE_SHARED") then                                             -- If it's tagged as barrier arc (see barrier_arc_init.lua) do..
        local caststate = nil
        do -- Get cast state
            local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
            local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
            local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
            caststate = (string.sub(desc, i, j))
        end
        local pos_x, pos_y = EntityGetTransform(entity_id)
        local player_projectiles = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "CASTSTATE_SHARED") or {}
        for index = 1, #player_projectiles do
            local target = player_projectiles[index]
            local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
            local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
            local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
            local target_caststate = (string.sub(desc, i, j))
            if target_caststate == caststate then                                                   -- if it matches this projectile's cast state then..
                local function lerp(a, b, t) return a * (1 - t) + b * t end                         -- Setup
                local tx, ty = EntityGetTransform(target)                                           -- calculate distance
                local distance = math.sqrt(math.pow(tx - pos_x, 2) + math.pow(ty - pos_y, 2))       -- every 12 units of distance place a wall piece
                for dist = 1, distance, 12 do   
                    local px = lerp(pos_x, tx, (1 / distance) * dist)                               -- lerp the position so we go between the 2 shots
                    local py = lerp(pos_y, ty, (1 / distance) * dist)   
                    ---@diagnostic disable-next-line: undefined-global  
                    local wall_piece = shoot_projectile_from_projectile(                            -- create projectiles
                        entity_id,
                        "data/entities/projectiles/deck/wall_piece.xml",
                        px, py,
                        0, 0
                    )
                    local projectile = EntityGetFirstComponentIncludingDisabled(wall_piece, "ProjectileComponent")  -- Set it's lifetime to 2f and make it not be caught in the checks to prevent frame issue
                    ---@diagnostic disable-next-line: param-type-mismatch
                    ComponentSetValue2(projectile, "lifetime", 2)
                end
            end
        end
    end
end


-- NEW OPTIMIZATION
--[[

Assemble table of projectiles in state -> make barrier to next projectile in table (wrap around last proj) -> ez win 

]]