dofile_once("mods/anvil_of_destiny/files/scripts/mod_interop.lua")

-- Tele
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_teleportation",
    {
        "COPITH_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
        "COPITH_TRANSMISSION_CAST",
        "COPITH_TELEPORT",
    },
1 )

-- Unstable tele
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_unstable_teleportation",
    {
        "COPITH_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
        "COPITH_TRANSMISSION_CAST",
        "COPITH_TELEPORT_BAD"
    },
1 )

-- Blood (ULTRAKILL!!!!!!!!!!)
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "blood",
    {
        "COPITH_HITFX_BLOODY_2X_DAMAGE_POISONED",
    },
1 )

-- Water
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "water",
    {
        "COPITH_POWDER_TO_WATER",
        "COPITH_HITFX_WET_2X_DAMAGE_FREEZE",
    },
1 )

-- Piss
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "urine",
    {
        "COPITH_SUMMON_JAR_URINE",
    },
1 )

-- Berserkium
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_berserk ",
    {
        "COPITH_RECHARGE_UNSTABLE",
        "COPITH_STATIC_TO_EXPLOSION",
    },
1 )

-- Lava
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "lava ",
    {
        "COPITH_MATERIAL_LAVA",
    },
1 )

-- Vomit
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "vomit",
    {
        "COPITH_VOMERE",
    },
1 )

-- Acid  
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "acid",
    {
        "COPITH_ACID",
    },
1 )

-- Precursor 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "midas_precursor",
    {
        "COPITH_LIGHT_BULLET_DEATH_TRIGGER",
        "COPITH_SILVER_BULLET_DEATH_TRIGGER",
        "COPITH_SILVER_MAGNUM_DEATH_TRIGGER",
    },
1 )

-- Midas 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "midas",
    {
        "COPITH_NUGGET_SHOT",
        "COPITH_COIN",
        "COPITH_ALT_FIRE_COIN",
    },
1 )

-- Cement 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "cement",
    {
        "COPITH_CEMENT",
        "COPITH_ARC_CONCRETE",
        "COPITH_CONCRETEBALL",
    },
1 )

-- Poly 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_polymorph",
    {
        "COPITH_POLYMORPH",
        "COPITH_SUMMON_HAMIS",
        "COPITH_BLOODTENTACLE",
    },
1 )

-- Poly 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_random_polymorph",
    {
        "COPITH_POLYMORPH",
        "COPITH_SUMMON_HAMIS",
        "COPITH_BLOODTENTACLE",
    },
1 )

-- Poly 
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_unstable_polymorph",
    {
        "COPITH_POLYMORPH",
        "COPITH_SUMMON_HAMIS",
        "COPITH_BLOODTENTACLE",
    },
1 )

-- Pheremones
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_charm",
    {
        "COPITH_CHARM_FIELD",
        "COPITH_SUMMON_HAMIS",
    },
1 )

-- Healy juice
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_hp_regeneration ",
    {
        "COPITH_OPHIUCHUS",
        "COPITH_CLOUD_MAGIC_LIQUID_HP_REGENERATION",
    },
1 )

-- Hastium
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_faster_levitation_and_movement ",
    {
        "COPITH_LUNGE",
    },
1 )

-- Conc mana
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "magic_liquid_mana_regeneration",
    {
        "COPITH_MANA_ENGINE",
        "COPITH_MANA_EFFICENCY",
        "COPITH_MANA_RANDOM",
        "COPITH_PASSIVE_MANA",
    },
1 )

-- Funny monster powder
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "monster_powder_test",
    {
        "COPITH_SUMMON_HAMIS",
    },
1 )

-- Funny monster powder
---@diagnostic disable-next-line: undefined-global
append_effect("monster_powder_test", function(wand)
    if math.random() > 0.85 then
        wand:AddSpells("COPITH_SUMMON_HAMIS")
    end
end)

-- Slicy rune
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "runestone_disc",
    {
        "COPITH_ZENITH_DISC",
    },
1 )

-- Slow rune
---@diagnostic disable-next-line: undefined-global
potion_recipe_add_spells( "runestone_slow",
    {
        "COPITH_SLOW",
    },
1 )

    -- TODO: THE OTHER ITEMS!