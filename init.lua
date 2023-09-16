--[[
Hello seeker of knowledge.

Keep your eyes open, for there is much to come.
]]

COPIS_THINGS_VERSION = "0.5"

-- NOTICE! This is CRAP! I will be REWRITING THIS LIBRARY!
dofile_once("mods/copis_things/files/scripts/lib/polytools/polytools_init.lua").init( "mods/copis_things/files/scripts/lib/polytools/")

-- gus you fuck this file literally doesnt exist you broke my mod
---@module "setupCompatibility"
--local compatibility = dofile_once("mods/copis_things/files/setupCompatibility.lua")

---@module "gui"
local Gui = dofile_once("mods/copis_things/files/scripts/gui/gui.lua")

--#region stuff
--[[
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
        -- Edit perk.lua
        ModLuaFileAppend("data/scripts/perks/perk.lua", "mods/copis_things/files/scripts/perk/perk_append.lua")
    end,

    translations = function ()
        local translations = ModTextFileGetContent( "data/translations/common.csv" );
        if translations ~= nil then
            while translations:find("\r\n\r\n") do
                translations = translations:gsub("\r\n\r\n","\r\n");
            end
            local files = {"perks", "actions", "effects", "other"}
            for i=1, #files do
                local new_translations = ModTextFileGetContent( table.concat({"mods/copis_things/files/translations/", files[i], ".csv"}) );
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
        ModMaterialsFileAdd("mods/copis_things/files/materials_test.xml")
    end,

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

--#endregion

--#region callbacks
--[[
  ██████████          ██        ██              ██              ████████████          ██          ██████████    ██        ██    ██████████    
██          ██      ██  ██      ██              ██              ██          ██      ██  ██      ██          ██  ██      ██    ██          ██  
██                ██      ██    ██              ██              ██          ██    ██      ██    ██              ██    ██      ██              
██              ██          ██  ██              ██              ████████████    ██          ██  ██              ██████          ██████████    
██              ██████████████  ██              ██              ██          ██  ██████████████  ██              ██    ██                  ██  
██          ██  ██          ██  ██              ██              ██          ██  ██          ██  ██          ██  ██      ██    ██          ██  
  ██████████    ██          ██  ██████████████  ██████████████  ████████████    ██          ██    ██████████    ██        ██    ██████████    
]]

function OnModInit()
    local flag = "this_should_never_spawn"
    if HasFlagPersistent(flag) then
        RemoveFlagPersistent(flag)
    end
    if HasFlagPersistent("copis_things_meta_spell") then
        AddFlagPersistent("copis_things_meta_spell_action")
    else
        RemoveFlagPersistent("copis_things_meta_spell_action")
    end
    content.actions()
    content.perks()
    content.translations()
    content.greeks()
    content.statuses()
    content.materials()
    --compatibility.setupModCompat()
end

function OnWorldInitialized()
    GlobalsSetValue("copis_things_version", COPIS_THINGS_VERSION)
    Gui:Setup()
    experimental.loadspell()
    experimental.spell_visualizer()
    GamePrint(("Copi's things INDEV %s"):format(COPIS_THINGS_VERSION))
end

function OnWorldPreUpdate()
    Gui:Update()

	-- TODO: REMOVE THIS
    if InputIsKeyJustDown(19) then
		Spells = Spells or { "COPIS_THINGS_PSYCHIC_SHOT", "COPIS_THINGS_LUNGE", "COPIS_THINGS_PROJECTION_CAST", "COPIS_THINGS_SLOW",
			"COPIS_THINGS_CLAIRVOYANCE", "COPIS_THINGS_ANCHORED_SHOT", "COPIS_THINGS_LEVITY_SHOT", "COPIS_THINGS_SEPARATOR_CAST",
			"COPIS_THINGS_SPREAD", "COPIS_THINGS_DART", "COPIS_THINGS_TEMPORARY_CIRCLE", "COPIS_THINGS_LARPA_FORWARDS",
			"COPIS_THINGS_WISPY_SHOT", "COPIS_THINGS_GUNNER_SHOT", "COPIS_THINGS_GUNNER_SHOT_STRONG", "COPIS_THINGS_SOIL_TRAIL",
			"COPIS_THINGS_CONCRETEBALL", "COPIS_THINGS_ZENITH_DISC", "COPIS_THINGS_EVISCERATOR_DISC",
			"COPIS_THINGS_SUMMON_HAMIS", "COPIS_THINGS_SILVER_BULLET", "COPIS_THINGS_SILVER_MAGNUM",
			"COPIS_THINGS_SILVER_BULLET_DEATH_TRIGGER", "COPIS_THINGS_SILVER_MAGNUM_DEATH_TRIGGER",
			"COPIS_THINGS_SLOTS_TO_POWER", "COPIS_THINGS_UPGRADE_GUN_SHUFFLE", "COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD",
			"COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND", "COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER",
			"COPIS_THINGS_UPGRADE_GUN_CAPACITY", "COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT", "COPIS_THINGS_UPGRADE_RELOAD_TIME",
			"COPIS_THINGS_UPGRADE_SPREAD_DEGREES", "COPIS_THINGS_UPGRADE_MANA_MAX", "COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED",
			"COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT", "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE",
			"COPIS_THINGS_DAMAGE_LIFETIME", "COPIS_THINGS_HITFX_CRITICAL_CHARM", "COPIS_THINGS_HITFX_CRITICAL_ELECTROCUTED",
			"COPIS_THINGS_HITFX_CRITICAL_FROZEN", "COPIS_THINGS_PASSIVE_MANA", "COPIS_THINGS_FREEZING_VAPOUR_TRAIL",
			"COPIS_THINGS_VOID_TRAIL", "COPIS_THINGS_DAMAGE_CRITICAL", "COPIS_THINGS_DIMIGE", "COPIS_THINGS_POWER_SHOT",
			"COPIS_THINGS_STICKY_SHOT", "COPIS_THINGS_LOVELY_TRAIL", "COPIS_THINGS_STARRY_TRAIL", "COPIS_THINGS_SPARKLING_TRAIL",
			"COPIS_THINGS_NULL_TRAIL", "COPIS_THINGS_ROOT_GROWER", "COPIS_THINGS_HOMING_ANTI",
			"COPIS_THINGS_ALT_FIRE_FLAMETHROWER", "COPIS_THINGS_DECOY", "COPIS_THINGS_DECOY_TRIGGER",
			"COPIS_THINGS_CIRCLE_EDIT_WANDS_EVERYWHERE", "COPIS_THINGS_MINI_SHIELD", "COPIS_THINGS_NGON_SHAPE",
			"COPIS_THINGS_STORED_SHOT", "COPIS_THINGS_BARRIER_TRAIL", "COPIS_THINGS_DEATH_RAY",
			"COPIS_THINGS_LIGHT_BULLET_DEATH_TRIGGER", "COPIS_THINGS_IF_PLAYER", "COPIS_THINGS_IF_ALT_FIRE",
			"COPIS_THINGS_ZIPPING_ARC", "COPIS_THINGS_SLOW_BULLET_TIMER_2", "COPIS_THINGS_SLOW_BULLET_TIMER_N",
			"COPIS_THINGS_FALSE_SPELL", "COPIS_THINGS_PSI", "COPIS_THINGS_DELTA", "COPIS_THINGS_AUTO_ENEMIES",
			"COPIS_THINGS_AUTO_FRAME", "COPIS_THINGS_AUTO_HOLSTER", "COPIS_THINGS_AUTO_HP", "COPIS_THINGS_AUTO_HURT",
			"COPIS_THINGS_AUTO_PROJECTILE", "COPIS_THINGS_ICICLE_LANCE", "COPIS_THINGS_STATIC_TO_EXPLOSION",
			"COPIS_THINGS_LIQUID_TO_SOIL", "COPIS_THINGS_POWDER_TO_WATER", "COPIS_THINGS_POWDER_TO_STEEL", "COPIS_THINGS_ZAP",
			"COPIS_THINGS_MATRA_MAGIC", "COPIS_THINGS_VOMERE", "COPIS_THINGS_CIRCLE_RANDOM", "COPIS_THINGS_CLOUD_RANDOM",
			"COPIS_THINGS_TOUCH_RANDOM", "COPIS_THINGS_CHUNK_OF_RANDOM", "COPIS_THINGS_MATERIAL_RANDOM",
			"COPIS_THINGS_SEA_RANDOM", "COPIS_THINGS_SUMMON_ANVIL", "COPIS_THINGS_ARCANE_TURRET",
			"COPIS_THINGS_ARCANE_TURRET_PATIENT", "COPIS_THINGS_RECURSIVE_LARPA", "COPIS_THINGS_LARPA_FIELD",
			"COPIS_THINGS_SHIELD_SAPPER", "COPIS_THINGS_PAPER_SHOT", "COPIS_THINGS_FEATHER_SHOT", "COPIS_THINGS_SCATTER_6",
			"COPIS_THINGS_SCATTER_8", "COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION", "COPIS_THINGS_CHAOS_SPRITES",
			"COPIS_THINGS_SHIELD_GHOST", "COPIS_THINGS_VACUUM_CLAW", "COPIS_THINGS_CAUSTIC_CLAW", "COPIS_THINGS_LUMINOUS_BLADE",
			"COPIS_THINGS_INVERT", "COPIS_THINGS_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH", "COPIS_THINGS_DEATH_CROSS_TRAIL",
			"COPIS_THINGS_GLITTERING_TRAIL", "COPIS_THINGS_SILVER_BULLET_RAY", "COPIS_THINGS_SILVER_BULLET_RAY_6",
			"COPIS_THINGS_SILVER_BULLET_ON_DEATH", "COPIS_THINGS_SILVER_BULLET_RAY_SPIN", "COPIS_THINGS_SILVER_BULLET_RAY_ENEMY",
			"COPIS_THINGS_ICE_ORB", "COPIS_THINGS_CHARM_FIELD", "COPIS_THINGS_MANA_RANDOM",
			"COPIS_THINGS_HITFX_WET_2X_DAMAGE_FREEZE", "COPIS_THINGS_HITFX_BLOODY_2X_DAMAGE_POISONED",
			"COPIS_THINGS_HITFX_OILED_2X_DAMAGE_BURN", "COPIS_THINGS_BLINDNESS", "COPIS_THINGS_MATERIAL_LAVA",
			"COPIS_THINGS_MATERIAL_MAGIC_LIQUID_POLYMORPH", "COPIS_THINGS_OPHIUCHUS", "COPIS_THINGS_NUGGET_SHOT",
			"COPIS_THINGS_ASTRAL_VORTEX", "COPIS_THINGS_LASER_EMITTER_SMALL", "COPIS_THINGS_ACID", "COPIS_THINGS_CEMENT",
			"COPIS_THINGS_LIFETIME_RANDOM", "COPIS_THINGS_DELAY_2", "COPIS_THINGS_DELAY_3", "COPIS_THINGS_DELAY_X",
			"COPIS_THINGS_CHAOS_RAY", "COPIS_THINGS_ORDER_DECK", "COPIS_THINGS_MANA_EFFICENCY", "COPIS_THINGS_ULT_DAMAGE",
			"COPIS_THINGS_ULT_DRAW_MANY", "COPIS_THINGS_ULT_LIFETIME", "COPIS_THINGS_ULT_CONTROL", "COPIS_THINGS_ULT_RECHARGE",
			"COPIS_THINGS_ULT_PROTECTION", "COPIS_THINGS_BALLOON", "COPIS_THINGS_HOMING_SEEKER", "COPIS_THINGS_PERSISTENT_SHOT",
			"COPIS_THINGS_HYPER_BOUNCE", "COPIS_THINGS_ULTRAKILL", "COPIS_THINGS_WOOD_BRUSH", "COPIS_THINGS_HOMING_ANTI_SHOOTER",
			"COPIS_THINGS_ALCOHOL_SHOT", "COPIS_THINGS_SPREAD_DAMAGE", "COPIS_THINGS_SUMMON_JAR_URINE",
			"COPIS_THINGS_DAMAGE_BOUNCE", "COPIS_THINGS_DIE", "COPIS_THINGS_ENERGY_SHIELD_DIRECTIONAL",
			"COPIS_THINGS_CLEANING_TOOL", "COPIS_THINGS_COIN", "COPIS_THINGS_ALT_FIRE_COIN", "COPIS_THINGS_VERTICAL_ARC",
			"COPIS_THINGS_ARC_CONCRETE", "COPIS_THINGS_MANA_ENGINE", "COPIS_THINGS_RECHARGE_ENGINE",
			"COPIS_THINGS_DAMAGE_ENGINE", "COPIS_THINGS_SHIELD_ENGINE", "COPIS_THINGS_RECHARGE_UNSTABLE",
			"COPIS_THINGS_RAINBOW_TRAIL", "COPIS_THINGS_CONFETTI_TRAIL", "COPIS_THINGS_SWORD_FORMATION",
			"COPIS_THINGS_LINK_SHOT", "COPIS_THINGS_REDUCE_KNOCKBACK", "COPIS_THINGS_BARRIER_ARC", "COPIS_THINGS_LIQUID_EATER",
			"COPIS_THINGS_BURST_FIRE", "COPIS_THINGS_TRANSMISSION_CAST", "COPIS_THINGS_CIRCLE_BOOST",
			"COPIS_THINGS_META_SKIP_PROJECTILE", "COPIS_THINGS_META_STOP_SKIP_PROJECTILE", "COPIS_THINGS_META_SKIP_ALL",
			"COPIS_THINGS_META_SKIP_NONE", "COPIS_THINGS_META_SKIP_MODIFIER", "COPIS_THINGS_META_SKIP_PROJECTILE_IF_PROJECTILE",
			"COPIS_THINGS_SUMMON_FLASK", "COPIS_THINGS_SUMMON_FLASK_FULL", "COPIS_THINGS_TELEPORT", "COPIS_THINGS_TELEPORT_BAD",
			"COPIS_THINGS_HOMING_BOUNCE", "COPIS_THINGS_HOMING_BOUNCE_CURSOR", "COPIS_THINGS_HOMING_INTERVAL",
			"COPIS_THINGS_HOMING_MACROSS", "COPIS_THINGS_POLYMORPH", "COPIS_THINGS_SUS_TRAIL", "COPIS_THINGS_MUSIC_PLAYER",
			"COPIS_THINGS_GRAPPLING_HOOK", "COPIS_THINGS_SPECTRAL_HOOK", "COPIS_THINGS_GRAPPLING_HOOK_SHOT",
			"COPIS_THINGS_CIRCLE_ANCHOR", "COPIS_THINGS_GRAPPLING_HOOK_RAY_ENEMY", "COPIS_THINGS_ALT_FIRE_GRAPPLING_HOOK",
			"COPIS_THINGS_TRUE_CHAOS_RAY", "COPIS_THINGS_HITFX_LARPA", "COPIS_THINGS_ARCANA_TO_POWER",
			"COPIS_THINGS_DUPLICATE_ACTION", "COPIS_THINGS_SPINDOWN_SPELL", "COPIS_THINGS_DUPLICATE_ACTION_2",
			"COPIS_THINGS_DUPLICATE_ACTION_3", "COPIS_THINGS_IMPRINT", "COPIS_THINGS_ACTION_INVERSION", "COPIS_THINGS_BALANCE",
			"COPIS_THINGS_GILDED_AXE", "COPIS_THINGS_STARLIGHT_AXE", "COPIS_THINGS_TRIGGER_DAMAGE_RECEIVED",
			"COPIS_THINGS_RIPHOOK", "COPIS_THINGS_ALT_FIRE_RIPHOOK", "COPIS_THINGS_FIRESPHERE", "COPIS_THINGS_ALT_FIRE_BOMB",
			"COPIS_THINGS_LOOP_CAST", "COPIS_THINGS_ICE_CUBE", "COPIS_THINGS_MANA_DELTA", "COPIS_THINGS_PAIN_RAY",
			"COPIS_THINGS_HOLY_RAY", "COPIS_THINGS_INFERNAL_STREAK", "COPIS_THINGS_AVERAGE_MANA", "COPIS_THINGS_AMMO_BOX",
			"COPIS_THINGS_AMMO_FROM_HP", "COPIS_THINGS_LARPA_BUT_GOOD", "COPIS_THINGS_GATE_MANA", "COPIS_THINGS_GATE_HP",
			"COPIS_THINGS_GLYPH_OF_BULLSHIT", "SLOW_BUT_STEADY", "RANDOM_SPELL",
		}
		local x, y = DEBUG_GetMouseWorld()
		CreateItemActionEntity(Spells[math.random(1,#Spells)], x, y)
    end
end

function OnModPreInit()
	AddFlagPersistent("sp_nolla")
end

function OnPlayerSpawned()
    Gui:PlayerSpawned()
	if not GameIsBetaBuild() then
		GamePrintImportant("The Gods want you to use beta branch!", "Please?", "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png")
		GamePrint("If you're arvi, hi!!!")
	end
end

function OnWorldPostUpdate()
    Gui:Tr()
end

--#endregion
-- what the FUCK is this file