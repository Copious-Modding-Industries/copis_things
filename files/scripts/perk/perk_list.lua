to_insert =
{
            --  Health multiplication
    {
        id = "COPIS_THINGS_MULTIPLY_HP",
        ui_name = "Health multiplication",
        ui_description = "Your max health is tripled, but you're unable to gain more health from hearts",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/multiply_hp.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/multiply_hp.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for i,damagemodel in ipairs(damagemodels) do
                    local hp = ComponentGetValue2( damagemodel, "hp" ) * 3
                    local max_hp = ComponentGetValue2( damagemodel, "max_hp" ) * 3
                    ComponentSetValue2( damagemodel, "max_hp", max_hp )
                    ComponentSetValue2( damagemodel, "max_hp_cap", max_hp )
                    ComponentSetValue2( damagemodel, "hp", hp )
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for i,damagemodel in ipairs(damagemodels) do
                    local hp = ComponentGetValue2( damagemodel, "hp" ) / 3
                    local max_hp = ComponentGetValue2( damagemodel, "max_hp" ) / 3
                    ComponentSetValue2( damagemodel, "max_hp", max_hp )
                    ComponentSetValue2( damagemodel, "max_hp_cap", 0 )
                    ComponentSetValue2( damagemodel, "hp", hp )
                end
            end
        end,
    },
    --[[
            --  Alchemic aura
    {
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
    },
            --  Alchemic aura
    {
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
    },
    ]]--
            --  Mana efficiency
    {
        id = "COPIS_THINGS_MANA_EFFICIENCY",
        ui_name = "Mana efficiency",
        ui_description = "Spells you cast will cost half as much mana",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/mana_efficiency.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/mana_efficiency.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddComponent( entity_who_picked,"ShotEffectComponent",{
                extra_modifier = "copis_things_mana_efficiency"
            })
        end,
    },
            --  Short temper
    {
        id = "COPIS_THINGS_SHORT_TEMPER",
        ui_name = "Short temper",
        ui_description = "Taking damage makes you enter a state of rage briefly",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/short_temper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/short_temper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddComponent( entity_who_picked, "LuaComponent", {
                script_damage_received="mods/copis_things/files/scripts/perk/damage_recieved/short_temper.lua"
            })
        end,
    },
            --  Swapper
    {
        id = "COPIS_THINGS_SWAPPER",
        ui_name = "Swapper",
        ui_description = "Confuse your enemies by swapping places with your attacker.",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/swapper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/swapper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddComponent( entity_who_picked, "LuaComponent", {
                script_damage_received="mods/copis_things/files/scripts/perk/damage_recieved/swapper.lua"
            })
        end,
    },
--[[
        --  Duplicate Wand (One-Off)
    {
        id = "COPIS_THINGS_WAND_DUPLICATE",
        ui_name = "Duplicate Wand (One-Off)",
        ui_description = "Create a copy of your wand.",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/wand_duplicate.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/wand_duplicate.png",
		stackable = STACKABLE_YES,
		max_in_perk_pool = 3,
		one_off_effect = true,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x, y = EntityGetTransform( entity_who_picked );
            local wand = find_the_wand_held( entity_who_picked )
            if wand ~= nil then
                local cloned_wand = wand:Clone()
                cloned_wand:PlaceAt(x, y)
            end
        end,
    }
]]
}


for k, v in ipairs(to_insert) do
    table.insert(perk_list, v)
end