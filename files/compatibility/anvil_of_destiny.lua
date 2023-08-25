dofile_once("mods/anvil_of_destiny/files/scripts/mod_interop.lua")

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

-- Funny monster powder
---@diagnostic disable-next-line: undefined-global
append_effect("monster_powder_test", function(wand)
    if math.random() > 0.85 then
        wand:AddSpells("COPIS_THINGS_SUMMON_HAMIS")
    end
end)

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
-- I should likely remove this, seeing as conga handled it in apo... todo, double check apo anvil compat
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