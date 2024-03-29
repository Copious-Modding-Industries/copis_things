local function upgrade_projectile( entity_filename )
    -- check if shooter has perk
    local vsc = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "VariableStorageComponent", "upgrade_projectile")
    if vsc ~= nil then
        local stacks = ComponentGetValue2(vsc, "value_int") or 0
        local upgrades = dofile_once("mods/copis_things/files/scripts/gun/upgrade_projectile_list.lua")
        for i = 1, stacks do
            for from, to in pairs(upgrades) do
                if entity_filename == from then
                    if math.random() > 0.5 then
                        entity_filename = to
                    end
                end
            end
        end
    end
    return entity_filename
end

function add_projectile( entity_filename )
    entity_filename = upgrade_projectile( entity_filename )
    copi_state.old._add_projectile( entity_filename )
end

function add_projectile_trigger_timer( entity_filename, delay_frames, action_draw_count )
    entity_filename = upgrade_projectile( entity_filename )
    copi_state.old._add_projectile_trigger_timer( entity_filename, delay_frames, action_draw_count )
end

function add_projectile_trigger_hit_world( entity_filename, action_draw_count )
    entity_filename = upgrade_projectile( entity_filename )
    copi_state.old._add_projectile_trigger_hit_world( entity_filename, action_draw_count )
end

function add_projectile_trigger_death( entity_filename, action_draw_count )
    entity_filename = upgrade_projectile( entity_filename )
    copi_state.old._add_projectile_trigger_death( entity_filename, action_draw_count )
end