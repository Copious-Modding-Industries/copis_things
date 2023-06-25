---@diagnostic disable-next-line: lowercase-global
function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
    if damage > 0 then
        -- Get table of damage triggers
        local damage_triggers = {}
        local player_projs = EntityGetWithTag("player_projectile") or {}
        for i=1,#player_projs do
            if EntityGetName(player_projs[i]) == "copi_trigger_damage_received" then
                damage_triggers[#damage_triggers+1] = player_projs[i]
            end
        end
        if #damage_triggers > 0 then
            -- Sort to get the oldest trigger, then fire it
            table.sort( damage_triggers, function( a, b ) return a < b end )
            EntityKill(damage_triggers[1])
        end
    end
end