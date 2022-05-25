table.insert(perk_list,{
    id = "COPIS_THINGS_ALCHEMY_AURA",
    ui_name = "Alchemic Aura",
    ui_description = "Transmutes some materials into other ones",
    ui_icon = "mods/copis_things/files/sprites/perks/ui/alchemic_aura.png",
    perk_icon = "mods/copis_things/files/sprites/perks/alchemic_aura.png",
    stackable = STACKABLE_NO,
    usable_by_enemies = true,
    func = function( entity_perk_item, entity_who_picked, item_name )
        local x,y = EntityGetTransform( entity_who_picked )
        local child_id = EntityLoad( "mods/copis_things/files/entities/misc/perk/alchemy_aura.xml", x, y )
        EntityAddTag( child_id, "perk_entity" )
        EntityAddChild( entity_who_picked, child_id )
    end,
})
table.insert(perk_list,{
    id = "COPIS_THINGS_HALLOWED_STEP",
    ui_name = "Hallowed Step",
    ui_description = "Purifies stone within a short radius",
    ui_icon = "mods/copis_things/files/sprites/perks/ui/hallowed_step.png",
    perk_icon = "mods/copis_things/files/sprites/perks/hallowed_step.png",
    stackable = STACKABLE_NO,
    usable_by_enemies = true,
    func = function( entity_perk_item, entity_who_picked, item_name )
        local x,y = EntityGetTransform( entity_who_picked )
        local child_id = EntityLoad( "mods/copis_things/files/entities/misc/perk/hallowed_step.xml", x, y )
        EntityAddTag( child_id, "perk_entity" )
        EntityAddChild( entity_who_picked, child_id )
    end,
})

table.insert(perk_list,{
    id = "COPIS_THINGS_REGEN",
    ui_name = "Regeneration",
    ui_description = "You regenerate health rapidly, but a curse affects you..",
    ui_icon = "mods/copis_things/files/sprites/perks/ui/regen.png",
    perk_icon = "mods/copis_things/files/sprites/perks/regen.png",
    stackable = STACKABLE_NO,
    game_effect = "REGENERATION",
    usable_by_enemies = true,
    func = function( entity_perk_item, entity_who_picked, item_name )
        local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
        if( damagemodels ~= nil ) then
            for i,damagemodel in ipairs(damagemodels) do
                local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
                local max_hp = 4
                --ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
                ComponentSetValue( damagemodel, "max_hp", max_hp )
                ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
                ComponentSetValue( damagemodel, "hp", max_hp )
            end
        end
    end,
    func_remove = function( entity_who_picked )
        local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
        if( damagemodels ~= nil ) then
            for i,damagemodel in ipairs(damagemodels) do
                local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ))
                ComponentSetValue( damagemodel, "max_hp_cap", 0.0 )
                if ( max_hp < 100 ) then
                    ComponentSetValue( damagemodel, "max_hp", 4 )
                    ComponentSetValue( damagemodel, "hp", 4 )
                end
            end
        end
    end,
})

    -- RESISTANCE AFFECTORS
perks_protection =
    {
        {
            id = "PROTECTION_FREEZE",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_POLYMORPH",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_POLYMORPH",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_CURSE",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_PROJECTILE",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_SLICE",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_MIDAS",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_MATERIAL",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },
        {
            id = "PROTECTION_IMPACT",
            ui_name = "$perk_protection_freeze",
            ui_description = "$perkdesc_protection_freeze",
            ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
            perk_icon = "data/items_gfx/perks/protection_freeze.png",
            game_effect = "PROTECTION_FREEZE",
            usable_by_enemies = true,
        },

    }


if ModSettingGet("Copis_Things.perks_protection") then
    for k, v in ipairs(perks_protection) do
        table.insert(perk_list, v)
    end
end