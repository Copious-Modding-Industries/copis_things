--[[
Hello seeker of knowledge.

I will speak many words to you through the past present and future.
But for now, rid yourself of this domain, as it is unstable and incomplete.
To base your future on the chaotic state of this project would only worsen them.
Now flee, escape until this primordial slate of commands is in it's final state.
]]

local meta = {

    version = function ()
        GlobalsSetValue("copis_things_version", "v0.4 SUMMIT CANDIDATE")
    end,

    flag_reset = function ()
        local flag = "this_should_never_spawn"
        if HasFlagPersistent(flag) then
            RemoveFlagPersistent(flag)
        end
    end

}

--[[ STUFF
  ██████████    ██████████████  ██          ██  ██████████████  ██████████████  
██          ██        ██        ██          ██  ██              ██              
██                    ██        ██          ██  ██              ██              
  ██████████          ██        ██          ██  ██████████      ██████████      
            ██        ██        ██          ██  ██              ██              
██          ██        ██        ██          ██  ██              ██              
  ██████████          ██          ██████████    ██              ██              
]]

local content = {

    actions = function ()
        -- Gun Extra Modifiers (status)
        ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
        -- Edit gun.lua
        ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_append.lua")
        -- Rework spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions_rework.lua")
        -- Add spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions.lua")
    end,

    perks = function ()
        -- Add perks
        ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
    end,

    translations = function ()
        local translations = ModTextFileGetContent( "data/translations/common.csv" );
        if translations ~= nil then
            while translations:find("\r\n\r\n") do
                translations = translations:gsub("\r\n\r\n","\r\n");
            end
            local files = {"perks", "actions"}
            for _, file in ipairs(files) do
                local new_translations = ModTextFileGetContent( table.concat({"mods/copis_things/files/translations/", file, ".csv"}) );
                translations = translations .. new_translations;
            end
            ModTextFileSetContent( "data/translations/common.csv", translations );
        end
    end,

    greeks = function ()
        local path = "data/entities/animals/boss_alchemist/death.lua"
        local contents = ModTextFileGetContent(path)
        local greeks = {
            psi = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_PSI") or true,
            delta = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_DELTA") or true
        }
        -- inject greeks
        contents = contents:gsub(
            [[local opts = { ]],
            table.concat{[[local opts = { ]] , greeks.psi and [["COPIS_THINGS_PSI", ]] or "", greeks.delta and [["COPIS_THINGS_DELTA", ]] or ""}
        )
        ModTextFileSetContent(path, contents)
    end,

    statuses = function ()
        -- Add statuses
        ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")
    end,

    materials = function ()
        ModMaterialsFileAdd("mods/copis_things/files/materials_nugget.xml")
        ModMaterialsFileAdd("mods/copis_things/files/materials_rainbow.xml")
    end,

}

local compatibility = {

    anvil = function ()
        if ModIsEnabled("anvil_of_destiny") then

            -- # Vanilla AOD compat 
            dofile_once("anvil_of_destiny/files/scripts/mod_interop.lua")

            -- Tele
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_teleportation",
                {
                    "COPIS_THINGS_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
                    "COPIS_THINGS_TRANSMISSION_CAST",
                    "COPIS_THINGS_TELEPORT",
                },
            1 )

            -- Unstable tele
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_unstable_teleportation",
                {
                    "COPIS_THINGS_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
                    "COPIS_THINGS_TRANSMISSION_CAST",
                    "COPIS_THINGS_TELEPORT_BAD"
                },
            1 )

            -- Blood (ULTRAKILL!!!!!!!!!!)
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "blood",
                {
                    "COPIS_THINGS_HITFX_BLOODY_2X_DAMAGE_POISONED",
                },
            1 )

            -- Water
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "water",
                {
                    "COPIS_THINGS_POWDER_TO_WATER",
                    "COPIS_THINGS_HITFX_WET_2X_DAMAGE_FREEZE",
                },
            1 )

            -- Piss
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "urine",
                {
                    "COPIS_THINGS_SUMMON_JAR_URINE",
                },
            1 )

            -- Berserkium
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_berserk ",
                {
                    "COPIS_THINGS_RECHARGE_UNSTABLE",
                    "COPIS_THINGS_STATIC_TO_EXPLOSION",
                },
            1 )

            -- Lava
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "lava ",
                {
                    "COPIS_THINGS_MATERIAL_LAVA",
                },
            1 )

            -- Vomit
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "vomit",
                {
                    "COPIS_THINGS_VOMERE",
                },
            1 )

            -- Acid  
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "acid",
                {
                    "COPIS_THINGS_ACID",
                },
            1 )

            -- Precursor 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "midas_precursor",
                {
                    "COPIS_THINGS_LIGHT_BULLET_DEATH_TRIGGER",
                    "COPIS_THINGS_SILVER_BULLET_DEATH_TRIGGER",
                    "COPIS_THINGS_SILVER_MAGNUM_DEATH_TRIGGER",
                },
            1 )

            -- Midas 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "midas",
                {
                    "COPIS_THINGS_NUGGET_SHOT",
                    "COPIS_THINGS_COIN",
                    "COPIS_THINGS_ALT_FIRE_COIN",
                },
            1 )

            -- Cement 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "cement",
                {
                    "COPIS_THINGS_CEMENT",
                    "COPIS_THINGS_ARC_CONCRETE",
                    "COPIS_THINGS_CONCRETEBALL",
                },
            1 )

            -- Poly 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_polymorph",
                {
                    "COPIS_THINGS_POLYMORPH",
                    "COPIS_THINGS_SUMMON_HAMIS",
                    "COPIS_THINGS_BLOODTENTACLE",
                },
            1 )

            -- Poly 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_random_polymorph",
                {
                    "COPIS_THINGS_POLYMORPH",
                    "COPIS_THINGS_SUMMON_HAMIS",
                    "COPIS_THINGS_BLOODTENTACLE",
                },
            1 )

            -- Poly 
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_unstable_polymorph",
                {
                    "COPIS_THINGS_POLYMORPH",
                    "COPIS_THINGS_SUMMON_HAMIS",
                    "COPIS_THINGS_BLOODTENTACLE",
                },
            1 )

            -- Pheremones
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_charm",
                {
                    "COPIS_THINGS_CHARM_FIELD",
                    "COPIS_THINGS_SUMMON_HAMIS",
                },
            1 )

            -- Healy juice
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_hp_regeneration ",
                {
                    "COPIS_THINGS_OPHIUCHUS",
                    "COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION",
                },
            1 )

            -- Hastium
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_faster_levitation_and_movement ",
                {
                    "COPIS_THINGS_LUNGE",
                },
            1 )

            -- Conc mana
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "magic_liquid_mana_regeneration",
                {
                    "COPIS_THINGS_MANA_ENGINE",
                    "COPIS_THINGS_MANA_EFFICENCY",
                    "COPIS_THINGS_MANA_RANDOM",
                    "COPIS_THINGS_PASSIVE_MANA",
                },
            1 )

            -- Funny monster powder
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "monster_powder_test",
                {
                    "COPIS_THINGS_SUMMON_HAMIS",
                },
            1 )

            -- Slicy rune
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "runestone_disc",
                {
                    "COPIS_THINGS_ZENITH_DISC",
                },
            1 )

            -- Slow rune
            ---@diagnostic disable-next-line: undefined-global
            potion_recipe_add_spells( "runestone_slow",
                {
                    "COPIS_THINGS_SLOW",
                },
            1 )

                -- TODO: THE OTHER ITEMS!

            -- # Apotheosis
            if ModIsEnabled("apotheosis") then

                -- Attunium
                ---@diagnostic disable-next-line: undefined-global
                potion_recipe_add_spells( "apotheosis_magic_liquid_attunium",
                    {
                        "COPIS_THINGS_HOMING_SEEKER",
                        "COPIS_THINGS_HOMING_BOUNCE",
                        "COPIS_THINGS_HOMING_INTERVAL",
                        "COPIS_THINGS_HOMING_MACROSS",
                    },
                1 )

                -- Velocium
                ---@diagnostic disable-next-line: undefined-global
                potion_recipe_add_spells( "apotheosis_magic_liquid_velocium",
                    {
                        "COPIS_THINGS_LUNGE",
                        "Upgrade - Spell speed multiplier (One-off)",
                    },
                1 )

            end
        end
    end

}

local experimental = {

    loadspell = function ()
        if ModSettingGet("CopisThings.do_starting_crap") then
            local flag = "copis_things_spell_spawned"
            if not GameHasFlagRun(flag) then
                local pos = {
                    x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X")),
                    y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y")),
                }
                dofile("data/scripts/gun/gun.lua")
                SetRandomSeed(420, 69)
                local result = actions[Random(1, #actions)]
                CreateItemActionEntity( result.id, pos.x, pos.y )
                --[[local wands = {
                    "experimental/delaywand/wand",
                    "experimental/chargewand/wand",
                    "experimental/blinkwand/wand",
                }
                local result = wands[Random(1, #wands)]
                EntityLoad(table.concat{"mods/copis_things/files/entities/items/wands/", result, ".xml"}, pos.x, pos.y)]]
                GameAddFlagRun(flag)
            end
        end
    end,

    spell_visualizer = function ()
        if ModSettingGet("CopisThings.do_spell_visualizer") then
            local flag = "copis_things_spell_visualizer"
            if not GameHasFlagRun(flag) then
                local pos = {
                    x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X") - 100),
                    y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y") - 50),
                }

                function spawn_spell_visualizer( x, y )
                    EntityLoad( "data/entities/buildings/workshop_spell_visualizer.xml", x, y )
                    EntityLoad( "data/entities/buildings/workshop_aabb.xml", x, y )
                end

                spawn_spell_visualizer( pos.x, pos.y )

                GameAddFlagRun(flag)
            end
        end
    end

}

--[[ GUI
  ██████████    ██          ██  ██████  
██          ██  ██          ██    ██    
██              ██          ██    ██    
██    ████████  ██          ██    ██    
██          ██  ██          ██    ██    
██          ██  ██          ██    ██    
  ██████████      ██████████    ██████  
]]

local gui = {

    setup = function ()
        local mods_res = tonumber(GlobalsGetValue("mod_button_tr_width", "0"))
        GlobalsSetValue("copis_things_mod_button_reservation", tostring(mods_res))
        GlobalsSetValue("mod_button_tr_width", tostring(mods_res + 15))
    end,

    update = function ()
        dofile("mods/copis_things/files/scripts/gui/update.lua")
    end,

    tr_crap = function ()
        if GlobalsGetValue( "config_mod_button_tr_max", "0" ) == "0" then
            local current = GlobalsGetValue( "mod_button_tr_current", "0" )
            GlobalsSetValue( "config_mod_button_tr_max", current or "0" );
        end
        GlobalsSetValue( "mod_button_tr_current", "0" );
    end,

    spawned = function ()
        GlobalsSetValue( "mod_button_tr_width", "0" );
    end

}

--[[ CALLBACKS
  ██████████          ██        ██              ██              ████████████          ██          ██████████    ██        ██    ██████████    
██          ██      ██  ██      ██              ██              ██          ██      ██  ██      ██          ██  ██      ██    ██          ██  
██                ██      ██    ██              ██              ██          ██    ██      ██    ██              ██    ██      ██              
██              ██          ██  ██              ██              ████████████    ██          ██  ██              ██████          ██████████    
██              ██████████████  ██              ██              ██          ██  ██████████████  ██              ██    ██                  ██  
██          ██  ██          ██  ██              ██              ██          ██  ██          ██  ██          ██  ██      ██    ██          ██  
  ██████████    ██          ██  ██████████████  ██████████████  ████████████    ██          ██    ██████████    ██        ██    ██████████    
]]

function OnModInit()
    meta.flag_reset()
    content.actions()
    content.perks()
    content.translations()
    content.greeks()
    content.statuses()
    content.materials()
    compatibility.anvil()
end

function OnWorldInitialized()
    gui.setup()
    meta.version()
    experimental.loadspell()
    experimental.spell_visualizer()
end

function OnWorldPreUpdate()
    gui.update()
end

function OnPlayerSpawned()
    gui.spawned()
end

function OnWorldPostUpdate()
    gui.tr_crap()
end


GamePrint("Copi's things INDEV 0.3")