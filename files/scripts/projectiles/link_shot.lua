local entity_id = GetUpdatedEntityID()
if EntityGetName(entity_id) ~= "separator" then
    local caststate = nil
    do  -- Get cast state
        local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
        caststate = (string.sub(desc, i, j))
    end

    local player_projectiles = EntityGetWithTag("projectile_player") or {}
    for index = 1, #player_projectiles do
        local target = player_projectiles[index]
        local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
        local target_caststate = (string.sub(desc, i, j))
        if target_caststate == caststate then
            EntityKill(target)
        end
    end
end