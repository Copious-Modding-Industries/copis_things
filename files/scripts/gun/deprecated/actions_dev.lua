local to_insert = {
    {
        id                = "DEV",
        name              = "Dev",
        description       = "cast state data",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                print("[COPI'S THINGS CAST STATE PRINT START]")
                for k,v in pairs(c) do
                    print(k.." = "..tostring(v));
                end
                print("[COPI'S THINGS CAST STATE PRINT END]")
            end
        end,
    },

    {
        id                = "TEST_NOITHEOGONY",
        name              = "TEST_NOITHEOGONY",
        description       = "A powerful attack where one spins with their blade, cleaving enemies around them.\n \n \n Type: [Blade]\n Stamina: [1]\n Melee damage: [6]\n Slice damage: [4]",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                GamePrint("Hello!")
            end
        end,
    },
    {
        id = "COPIS_THINGS_LARPA_RAIN",
        author = "Copi",
        name = "Larpasade",
        description = "Creates arcs of barriers between projectiles (requires 2 projectile spells)",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/barrier_arc.png",
        type = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level = "6,10",
		spawn_probability = "0.1,0.2",
        price = 10,
        mana = 0,
        action = function()

            if not reflecting then
                if c.deck == nil then

                    -- generate table of action ids
                    local action_ids = {}
                    for i=1, #deck do
                        action_ids[#action_ids+1] = deck[i].id
                    end

                    -- Relies on gun.lua haxx refer to "gun_append.lua" if you want to use data transfer haxx
                    c.action_description = table.concat(
                        {
                            (c.action_description or ""),
                            "\nDECK|",
                            table.concat({action_ids}, ","),
                        }
                    )
                    c.deck = true
                end
            end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_arc.xml,"

            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_PROJECTILE_HOMING",
        author = "Copi",
        name = "Passive Homing",
        description = "All projectiles fired from this wand will slightly home in on enemies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/projectile_homing.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3",
        price = 800,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/projectile_homing.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ORBIT_SHOOTER",
        author = "Copi",
        name = "Orbital Shot",
        description = "Causes the projectile to orbit the shooter",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/orbit_shooter.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/orbit_shooter.xml,"
            draw_actions(1, true)
        end
    },
}

for _, value in ipairs(to_insert) do
    if (value.author == nil) then
        value.author = "Copi"
    end
    value.id = "COPIS_THINGS_" .. value.id
    table.insert(actions, value)
end